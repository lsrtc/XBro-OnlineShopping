package bean;

import java.util.ArrayList;
import java.util.List;

public class UserList {

	static List<User> users;
	
	public UserList() {
		this.users = new ArrayList<User>();
	}
	
	public static void add(User u) {
		users.add(u);
	}
	public List<User> getUserList() {
        return this.users;
    }
	public static User getUserByID(String userName) {
		for(User u : users) {
			if(u.getUserName().equals(userName)) {
				return u;
			}
		}
		return null;
	}
	public static Boolean CheckPwd(User cu) {
		for(User u : users) {
			if(u.getUserName().equals(cu.getUserName())) {
				if(u.getPassword().equals(cu.getPassword())) {
					return true;
				}
			}
		}
		return false;
	}
	
	public List<User> getUsers(){
		return this.users;
	}

}
