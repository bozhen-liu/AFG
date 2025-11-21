use std::sync::mpsc;
use std::thread;
use std::sync::mpsc::sync_channel;

fn main() {
    // Create a channel
    let (tx, rx) = mpsc::channel();
    let (tx2, rx2) = mpsc::channel();
    let (tx3, rx3) = sync_channel(2);

    // Spawn a thread to send data
    let sender_handle = thread::spawn(move || {
        let data = 42;
        println!("Sending: {}", data);
        tx.send(data).unwrap();
    });

    // Spawn a thread to receive data
    let receiver_handle = thread::spawn(move || {
        let received = rx.recv().unwrap();
        println!("Received: {}", received);
        received
    });

    // Spawn another thread to send data
    let sender_handle2 = thread::spawn(move || {
        let data2 = 84;
        println!("Sending second value: {}", data2);
        tx2.send(data2).unwrap();
    });

    // spawn another thread to receive data
    let receiver_handle2 = thread::spawn(move || {
        let received2 = rx2.recv().unwrap();
        println!("Received second value: {}", received2);
        received2
    });

    // spawn a thread to send data using sync::mpsc
    let sender_handle3 = thread::spawn(move || {
        let data3 = 168;
        println!("Sending sync third value: {}", data3);
        tx3.send(data3).unwrap();
    });

    // spawn a thread to receive data using sync::mpsc
    let receiver_handle3 = thread::spawn(move || {
        let received3 = rx3.recv().unwrap();
        println!("Received sync third value: {}", received3);
        received3
    });

    // Wait for both threads
    sender_handle.join().unwrap();
    let result = receiver_handle.join().unwrap();
    sender_handle2.join().unwrap();
    let result2 = receiver_handle2.join().unwrap();
    sender_handle3.join().unwrap();
    let result3 = receiver_handle3.join().unwrap();

    println!("Final result: {}", result);
    println!("Final result2: {}", result2);
    println!("Final result3: {}", result3);
}
