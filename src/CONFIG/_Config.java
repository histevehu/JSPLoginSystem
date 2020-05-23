package CONFIG;

public class _Config
{
    public static enum USER_NAME_TYPE
    {
        id, userName, email, illegal
    }

    public static int COOKIE_LIFE_TIME=30;

    public static String DB_CLASS= "com.mysql.jdbc.Driver";
    public static String DB_URL = "jdbc:mysql://localhost:3306/User?useUnicode=true&characterEncoding=utf8";
    public static String DB_USERNAME="root";
    public static String DB_PWD="hzw13579";


    public static String EMAIL_ACCOUNT="histevehu@qq.com";
    public static String EMAIL_AUTHOCODE="hhtbyigajucwfdhj";

    public static int ADMIN_CONSOLE_PAGESIZE=5;

    public static enum RESETPWD_FROM
    {
        forgetPwdEmail,logined,blank
    }
    public static enum LOGIN_FROM
    {
        _cookie,_session,illegal
    }
    public static enum ADMIN_ALTER_UESRINFO_TYPE{
        del,modify
    }

}
