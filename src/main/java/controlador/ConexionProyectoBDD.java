/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import java.sql.DriverManager;
import java.sql.SQLException;   //estructuras métodos o maneras que el proyecto siga corriendo y no deje sin funcionalidad

/**
 *
 * @author Usuario
 */
public class ConexionProyectoBDD {
    
    //Connection ayuda a la conexion con la BDD
    java.sql.Connection conexion;
     public java.sql.Connection conectar(){
        //LANZAR CÓDIGO DE PRUEBA 
        //Trato de excepciones try y catch
        try {
            //Manera de Conexión a la Base de Datos jdbc---tipo de persistencia/motor/
            Class.forName("com.mysql.jdbc.Driver");
            //Parámetros de conexión url/usuario/clave en mysql
            conexion=DriverManager.getConnection("jdbc:mysql://localhost/proyecto_kanban?autoReconnect=true&useSSL=false","root","feliz2011");
            System.out.println("CONECTADO"); 
        } catch (ClassNotFoundException | SQLException e)//CAPTURAR ERRORES 
        {
             System.out.println("ERROR DE CONEXION A LA BASE DE DATOS");
        }
        return conexion;
    }    
}
