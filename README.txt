speedtest_to_mysql by Johannes Grill
this script uses speedtest.py from github.com/sivel/speedtest-cli to gather the speed of your inet connection and then writes it to mysql database (external or internal)
you can then use the data however you want, e.g. make a php script to output the data in readable format on a website
this script is a frankensteinesque monster made from different scripts that fly around on the internet
thanks fly out to
github.com/sivel for speedtest.py
gist.github.com/Dergonic for the template that made this script work
reddit.com/user/Cr0nixx for another template that made its way via copypaste to this script
stackoverflow.com because who the fuck doesnt use stackoverflow all of the time
my mother

Also included in this package is a PHP script to display the data as website.
index.php is the index page that starts the table
data.php is the file that fills the data in a table
styles.css is the stylesheet to format the table

Your database structure should look like this:
db_name
	- db_table
		- timestamp		datetime			unique
		- ping			decimal (10,2)
		- download		decimal (10,2)
		- upload		decimal (10,2)
		- server		text UTF-8


place speedtest_mysql in a directory of your choice and create a cronjob to automatically run it whenever you want.
place index.php, data.php and styles.css on your webserver and see the magic.