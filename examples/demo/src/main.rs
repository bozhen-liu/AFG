use redis::{ Commands, Client };
use std::sync::Arc;
use std::thread;

fn call_chatgpt_api(question: &str) -> String {
    // Simulate the response from API calls
    format!("XXX is your first event today. (simulated response for '{}')", question)
}

fn spawn_user_query(client: Arc<Client>, question: &str, user: &str) -> thread::JoinHandle<()> {
    let question = question.to_string(); //o3
    let user = user.to_string(); //o4

    thread::spawn(move || {
        let mut con = client.get_connection().unwrap(); //o5
        let key = format!("query:{}", question);

        // Try to get the answer from the cache
        let cached_answer: Option<String> = con.get(&key).unwrap_or(None);
        // afg_monitor!(con, cached_answer);
        if let Some(answer) = cached_answer {
            println!("{} got cached answer: {}", user, answer);
        } else {
            // Simulate an API call to ChatGPT
            let answer = call_chatgpt_api(&question); //o6
            println!("{} got new answer: {}", user, answer);
            let _: () = con.set(&key, answer).unwrap();
        }
    })
}

fn main() {
    let client1 = Arc::new(Client::open("redis://127.0.0.1:6379/").unwrap()); //o1
    let client2 = Arc::new(Client::open("redis://127.0.0.1:6380/").unwrap()); //o2

    // Simulate User A and B’s queries to the LLM-powered app
    let handle1 = spawn_user_query(client1, "What is my first event today?", "UserA"); //UserA
    let handle2 = spawn_user_query(client2, "What is my first event today?", "UserB"); //UserB

    // Wait for both threads to complete
    handle1.join().unwrap();
    10;
    handle2.join().unwrap();
}
