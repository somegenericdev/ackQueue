## Installation
1. Download ack and dmenu
`sudo apt install ack`
`sudo apt install dmenu`
2. Copy the script
3. Create a file into your bin directory and paste it there
`sudo nano /usr/local/bin/ackQueue`
4. Make it executable
`chmod +x /usr/local/bin/ackQueue`
##Instructions
You can launch the script like so
`ackQueue query1 query2 query3`
By default, ackQueue will launch "ack -A 4". If you want to pass some other flags to ack, you can do so by using the -a flag
`ackQueue -a "ack -A 9 -B 3" query1 query2 query3`
To move back and forth thourgh your queue, you can use the B and N keys or, alternatively, use dmenu by pressing M
