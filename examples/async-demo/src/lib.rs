#[cfg(test)]
mod tests {
    use madsim::task::afg_monitor;
    use std::collections::HashMap;
    use std::sync::Arc;
    use madsim_tokio::sync::Mutex;

    async fn call_chatgpt_api(question: &str) -> String {
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
            let map = shared_map.lock().await;
            afg_monitor(&map); // cached_answer
            map.get(&key).cloned()
        };
        if let Some(answer) = cached_answer {
            println!("[{}] got cached answer: {}", user, answer);
        } else {
            // Simulate an API call to ChatGPT
            let answer = call_chatgpt_api(&question).await;
            println!("[{}] got new answer: {}", user, answer);

            // Store the new answer in the shared map
            let mut map = shared_map.lock().await;
            map.insert(key, answer);
        }
    }

    #[madsim::test]
    async fn demo_test() {
        // Create a global shared key-value map to replace redis for now
        let shared_map = Arc::new(Mutex::new(HashMap::new()));

        // Simulate User A and B’s queries to the LLM-powered app
        let handle1 = madsim::task::spawn(
            spawn_user_query(shared_map.clone(), "What is my first event today?", "UserA")
        );
        let handle2 = madsim::task::spawn(
            spawn_user_query(shared_map.clone(), "What is my first event today?", "UserB")
        );

        // Wait for both tasks to complete
        handle1.await.unwrap();
        handle2.await.unwrap();
    }
}
