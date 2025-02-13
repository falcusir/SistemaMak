/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class UsuarioModelo {

    private int idUsuario;
    private PersonaModelo idPersona;
    private String usuario;
    private String contraseña;
    private String rol;

    public UsuarioModelo() {
    }

    public UsuarioModelo(int idUsuario, PersonaModelo idPersona, String usuario, String contraseña, String rol) {
        this.idUsuario = idUsuario;
        this.idPersona = idPersona;
        this.usuario = usuario;
        this.contraseña = contraseña;
        this.rol = rol;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public PersonaModelo getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(PersonaModelo idPersona) {
        this.idPersona = idPersona;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    @Override
    public String toString() {
     return "DATOS USUARIO"+
                "Usuario: "+getUsuario()+"\n"+
                "Contraseña: "+getContraseña()+"\n"+
                "Rol: "+getRol();
    }

   
}
