package DB.DAO;

import DB.Entity.DimUser;
import DB.Entity.User;

public interface UserDAO_Interface
{
    int getNum_AllUser();
    User[] getAllUsers();
    User[] getUsers(int startAt, int size);
    User getUser(int id);
    User[] getDimUsers(DimUser dimUser);
    void delUser(int id);
    void modifyUser(User user);
    boolean isUserExisted(String type,String val);
}
