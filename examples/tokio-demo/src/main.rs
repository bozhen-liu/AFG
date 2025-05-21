use std::sync::Arc;
use std::collections::HashMap;
use std::sync::Mutex;

fn call_chatgpt_api(question: &str) -> String {
    // Simulate the response from API calls
    format!("XXX is your first event today. (simulated response for '{}')", question)
}

async fn spawn_user_query(
    shared_map: Arc<Mutex<HashMap<String, String>>>,
    question: &str,
    user: &str
) {
    let question = question.to_string();
    let user = user.to_string();

    let key = format!("query:{}", question);

    // Try to get the answer from the shared map
    let cached_answer = {
        let map = shared_map.lock();
        map.expect("REASON").get(&key).cloned()
    };
    if let Some(answer) = cached_answer {
        println!("[{}] got cached answer: {}", user, answer);
    } else {
        // Simulate an API call to ChatGPT
        let answer = call_chatgpt_api(&question);
        println!("[{}] got new answer: {}", user, answer);

        // Store the new answer in the shared map
        let map = shared_map.lock();
        map.expect("REASON").insert(key, answer);
    }
}

#[tokio::main]
async fn main() {
    // Create a global shared key-value map to replace redis for now
    let shared_map = Arc::new(Mutex::new(HashMap::new()));

    // Simulate User A and B’s queries to the LLM-powered app
    let handle1 = tokio::task::spawn(
        spawn_user_query(shared_map.clone(), "What is my first event today?", "UserA")
    );
    let handle2 = tokio::task::spawn(
        spawn_user_query(shared_map.clone(), "What is my first event today?", "UserB")
    );
    // Wait for both tasks to complete
    handle1.await.unwrap();
    handle2.await.unwrap();
}
