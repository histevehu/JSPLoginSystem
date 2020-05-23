package DB.Utils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class JdbcUtils
{
    private static DataSource dataSource = null;

    static
    {
        dataSource = new ComboPooledDataSource("DB");

    }

    public static void releaseConnection(Connection conn)
    {
        if (conn != null)
        {
            try
            {
                conn.close();
            } catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
    }

    public static Connection getConnection() throws SQLException
    {
        return dataSource.getConnection();
    }
}
