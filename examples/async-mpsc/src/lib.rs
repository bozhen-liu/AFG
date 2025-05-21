#[cfg(test)]
mod tests {
    use madsim::test;
    use madsim::task::afg_monitor;
    use madsim_tokio::sync::mpsc;
    use std::time::Duration;

    async fn send(tx: mpsc::Sender<u32>) {
        let value = 42;
        println!("[send] Sending value: {}", value);
        afg_monitor(&tx);
        tx.send(value).await.unwrap();
        println!("[send] Value sent successfully");
        madsim_tokio::time::sleep(Duration::from_millis(100)).await;
        println!("[send] Finished sleeping");
    }

    async fn receive(mut rx: mpsc::Receiver<u32>) -> u32 {
        println!("[receive] Waiting to receive value...");
        afg_monitor(&rx);
        let value = rx.recv().await.unwrap();
        println!("[receive] Received value: {}", value);
        value
    }

    // #[test]
    // async fn normal_test() {
    //     let (tx, rx) = mpsc::channel(1);

    //     // Spawn the sender and receiver tasks
    //     let send_task = madsim_tokio::task::spawn(send(tx));
    //     let receive_task = madsim_tokio::task::spawn(receive(rx));

    //     // Wait for both tasks to complete
    //     send_task.await.unwrap();
    //     let val = receive_task.await.unwrap();

    //     println!("[normal_test] Final received value: {}", val);
    //     assert_eq!(val, 42);
    // }

    #[madsim::test]
    async fn madsim_test() {
        let (tx, rx) = mpsc::channel(1);

        // Spawn the sender and receiver tasks
        let send_task = madsim::task::spawn(send(tx));
        let receive_task = madsim::task::spawn(receive(rx));

        // Wait for both tasks to complete
        send_task.await.unwrap();
        let val = receive_task.await.unwrap();

        println!("[madsim_test] Final received value: {}", val);
        assert_eq!(val, 42);
    }
}
