
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    public static Connection connect(){
        Connection connection= null;
        String host="localhost";
        String port="3306";
        String database="Tidsmaskinen";
        String cp="utf8";
        String username="root";
        String password="toor";
        String url="jdbc:mariadb://"+host+":"+port+"/"+database+"?characterEncoding="+cp;
        try{
            System.out.println("DB connecting....");
            connection= DriverManager.getConnection(url,username,password);
            System.out.println("connection valid:"+ connection.isValid(5));
        }catch (SQLException e){
            e.printStackTrace();
        }
        return  connection;
    }

    public static void disconnect(Connection connection){
        if(connection != null){
            try{
                connection.close();
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
    }
}
