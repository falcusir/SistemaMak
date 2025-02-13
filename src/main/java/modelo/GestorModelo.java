/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class GestorModelo extends PersonaModelo {
    private int idGestor;
    private PersonaModelo idPersona;
    private String fechaAsignacion;

    public GestorModelo() {
    }

    public GestorModelo(int idGestor, PersonaModelo idPersona, String fechaAsignacion) {
        this.idGestor = idGestor;
        this.idPersona = idPersona;
        this.fechaAsignacion = fechaAsignacion;
    }

    public GestorModelo(int idGestor, String fechaAsignacion, int idPersona, String nombre, String apellido, String cedula, String fechaNac, String direccion, String teléfono, String correo) {
        super(idPersona, nombre, apellido, cedula, fechaNac, direccion, teléfono, correo);
        this.idGestor = idGestor;
        this.fechaAsignacion = fechaAsignacion;
    }

    public int getIdGestor() {
        return idGestor;
    }

    public void setIdGestor(int idGestor) {
        this.idGestor = idGestor;
    }

    public void setIdPersona(PersonaModelo idPersona) {
        this.idPersona = idPersona;
    }

    public String getFechaAsignacion() {
        return fechaAsignacion;
    }

    public void setFechaAsignacion(String fechaAsignacion) {
        this.fechaAsignacion = fechaAsignacion;
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
                "Correo Electrónico: "+getCorreo()+"\n"+
                "Fecha de Asignación: "+getFechaAsignacion();
               
    }
    
    
}
