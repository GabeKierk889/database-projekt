import IndlaesPersonerOgTilmeldinger.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Database {
    private String query;
    private ResultSet result;
    private Connection connection;
    private PreparedStatement statement;

    public Database(){
        query= null;
        result= null;
        connection= null;
        statement=null;
    }

    public boolean checkPerson(String email){
        boolean exist=false;
        connection = DBConnection.connect();
        try{
            query="select *from person where email=?";
            statement= connection.prepareStatement(query);
            statement.setString(1,email);
            result=statement.executeQuery();
            exist=result.next();
            connection.commit();
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);
        }

        return exist;
    }

    public void createPerson(Person person){
        connection= DBConnection.connect();
        try{
           query="insert into person values(?,?,?,?,?,?)";
           statement=connection.prepareStatement(query);
           statement.setString(1,person.getEmail());
           statement.setString(2,person.getFornavn());
           statement.setString(3,person.getEfternavn());
           statement.setString(4,null);
           statement.setDate(5,  new java.sql.Date(person.getFoedselsdato().getTime()));
           statement.setString(6,person.getKoen());
           int rowsInserted = statement.executeUpdate();
           System.out.println("Rows inserted: " + rowsInserted);
        }catch (SQLException e){
            e.printStackTrace();

        }finally {
            DBConnection.disconnect(connection);
        }
    }

    public boolean checkBegivenhed(Tilmelding tilmelding){
        boolean exist=false;
        connection=DBConnection.connect();
        try{
            query="select *from begivenhed where ID=? and Dato=? and eventType=?";
            statement=connection.prepareStatement(query);
            statement.setString(1,tilmelding.getForeningsId());
            statement.setDate(2, new java.sql.Date(tilmelding.getEventDate().getTime()));
            statement.setString(3,tilmelding.getEventTypeId());
            result=statement.executeQuery();
            exist=result.next();
            connection.commit();

        }catch (SQLException e){
           e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);
        }
        return exist;
    }

    public void createBegivenhed(Tilmelding begivenhed){
        connection=DBConnection.connect();
        try{
            query="insert into begivenhed values(?,?,?)";
            statement=connection.prepareStatement(query);
            statement.setString(1,begivenhed.getForeningsId());
            statement.setDate(2,new java.sql.Date(begivenhed.getEventDate().getTime()));
            statement.setString(3,begivenhed.getEventTypeId());
            int rowsInserted=statement.executeUpdate();
            System.out.println("Row inserted: " + rowsInserted);

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);

        }

    }

    public  boolean checkIdraetsforening(String Id){
        boolean exist=false;
        connection=DBConnection.connect();
        try{
            query="select *from Idrætsforening where Id=?";
            statement=connection.prepareStatement(query);
            statement.setString(1,Id);
            result=statement.executeQuery();
            exist=result.next();
            connection.commit();

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);

        }
        return exist;

    }

    public void createIdraetsforening(String Id){
        connection=DBConnection.connect();
        try{
            query="insert into Idrætsforening values(?,?,?,?,?)";
            statement=connection.prepareStatement(query);
            statement.setString(1,Id);
            statement.setString(2,"test");
            statement.setString(3,null);
            statement.setString(4,null);
            statement.setInt(5,12345);
            int rowsInserted=statement.executeUpdate();
            System.out.println("Row inserted: " + rowsInserted);

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);
        }
    }

    public void createDeltager(Person person, Tilmelding begivenhed){
        connection=DBConnection.connect();
        try{
            query="insert into Deltager (Email,ID,Dato,EventType,StartNr,Resultat) values(?,?,?,?,?,?)";
            statement=connection.prepareStatement(query);
            statement.setString(1,person.getEmail());
            statement.setString(2,begivenhed.getForeningsId());
            statement.setDate(3,new java.sql.Date(begivenhed.getEventDate().getTime()));
            statement.setString(4,begivenhed.getEventTypeId());
            statement.setDouble(5,0.0);
            statement.setTime(6, null);

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnection.disconnect(connection);
        }
    }
}
