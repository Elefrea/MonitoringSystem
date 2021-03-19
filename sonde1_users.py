import psutil;

users = psutil.users()
users_name = set([ user[0] for user in users ])
for user in users_name:
    print(user)

