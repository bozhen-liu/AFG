use std::sync::mpsc;
use std::thread;

fn main() {
    // Create a channel
    let (tx, rx) = mpsc::channel();
    
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
    
    // Wait for both threads
    sender_handle.join().unwrap();
    let result = receiver_handle.join().unwrap();
    
    println!("Final result: {}", result);
} 