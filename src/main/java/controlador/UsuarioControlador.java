/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import javax.swing.JOptionPane;
import modelo.PersonaModelo;
import modelo.UsuarioModelo;

/**
 *
 * @author Dell Core i7
 */
public class UsuarioControlador {
     //INSTANCIAR UN OBJETO DEL MODELO A INSERTAR
    private UsuarioModelo um;
    //INSTANCIAR LA CONEXION A LA BASE DE DATOS
    //Tiene todos los drivers de conexión
    ConexionProyectoBDD conectar = new ConexionProyectoBDD();
    //CLASE QUE ME PERMITE CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection)conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL a traves de cadenas
    PreparedStatement ejecutar;
    //obtener resultados de la consulta/estructura de datos--colecciones--fila o conjunto de resultados
    ResultSet resultado;

      public int verificarCredenciales(String usuario, String clave) {
        int estado = 0;
        try {
            CallableStatement ejecutar = conectado.prepareCall("{call sp_obtenerRolUsuario('" + usuario + "','" + clave + "',?)}");
            ejecutar.registerOutParameter(1, Types.INTEGER);
            ejecutar.execute();
            estado = ejecutar.getInt(1);
            ejecutar.close();
            return estado;
        } catch (SQLException e) {
            System.out.println("ERROR BDD" + e);
        }
        return estado;
    }
}
