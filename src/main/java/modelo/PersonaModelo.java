/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class PersonaModelo {
    private int idPersona;
    private String nombre;
    private String apellido;
    private String cedula;
    private String fechaNac;
    private String direccion;
    private String teléfono;
    private String correo; 

    public PersonaModelo() {
    }

    public PersonaModelo(int idPersona, String nombre, String apellido, String cedula, String fechaNac, String direccion, String teléfono, String correo) {
        this.idPersona = idPersona;
        this.nombre = nombre;
        this.apellido = apellido;
        this.cedula = cedula;
        this.fechaNac = fechaNac;
        this.direccion = direccion;
        this.teléfono = teléfono;
        this.correo = correo;
    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getFechaNac() {
        return fechaNac;
    }

    public void setFechaNac(String fechaNac) {
        this.fechaNac = fechaNac;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTeléfono() {
        return teléfono;
    }

    public void setTeléfono(String teléfono) {
        this.teléfono = teléfono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    @Override
    public String toString() {
        return "DATOS PERSONALES\n"+
                "Nombres: "+getNombre()+"\n"+
                "Apellidos: "+getApellido()+"\n"+
                "Cédula: "+getCedula()+"\n"+
                "Fecha de Nacimiento: "+getFechaNac()+"\n"+
                "Dirección: "+getDireccion()+"\n"+
                "Teléfono: "+getTeléfono()+"\n"+
                "Correo Electrónico: "+getCorreo();
    }
    
    
    
    
}


