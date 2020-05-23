package DB.Test;

import DB.Utils.JdbcUtils;

import java.sql.SQLException;

public class JdbcUtilsTest
{
    public static void main(String[] args)
    {
        JdbcUtils jdbcUtils=new JdbcUtils();
        try
        {
            System.out.println(jdbcUtils.getConnection().toString());
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
}
