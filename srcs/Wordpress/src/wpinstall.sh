cd /www
wp core is-installed
if [ $? == 1 ]; then
    wp core download
    wp core install --url=wordpress/ --path=/www --title="ft_services" --admin_user="admin" --admin_password="admin" --admin_email=jlensing@student.codam.nl --skip-email

    wp term create category Test
    wp term create category Testing
    wp post create --post_author=admin --post_category="Test" --post_title="This is a test post" --post_content="Ft_services sux" --post_excerpt=tag --post_status=publish
    
    wp user create AnAdmin AnAdmin@lol.com --role=administrator --user_pass=admin
    wp user create jordi axenth12@gmail.com --role=editor --user_pass=editor
    wp user create anotherUser user1@lol.com --role=editor --user_pass=user
    wp user create userNumber2 user2@lol.com --role=editor --user_pass=user

fi