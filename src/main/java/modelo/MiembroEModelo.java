/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class MiembroEModelo extends PersonaModelo {
    private int idMiembroEq;
    private PersonaModelo idPersona;
    private String estadoME;

    public MiembroEModelo() {
    }

    public MiembroEModelo(int idMiembroEq, PersonaModelo idPersona, String estadoME) {
        this.idMiembroEq = idMiembroEq;
        this.idPersona = idPersona;
        this.estadoME = estadoME;
    }

    public MiembroEModelo(int idMiembroEq, String estadoME, int idPersona, String nombre, String apellido, String cedula, String fechaNac, String direccion, String teléfono, String correo) {
        super(idPersona, nombre, apellido, cedula, fechaNac, direccion, teléfono, correo);
        this.idMiembroEq = idMiembroEq;
        this.estadoME = estadoME;
    }

    public int getIdMiembroEq() {
        return idMiembroEq;
    }

    public void setIdMiembroEq(int idMiembroEq) {
        this.idMiembroEq = idMiembroEq;
    }

    public void setIdPersona(PersonaModelo idPersona) {
        this.idPersona = idPersona;
    }

    public String getEstadoME() {
        return estadoME;
    }

    public void setEstadoME(String estadoME) {
        this.estadoME = estadoME;
    }

    @Override
    public String toString() {
    return "DATOS DEL MIEMBRO DEL EQUIPO\n"+
                "Nombres: "+getNombre()+"\n"+
                "Apellidos: "+getApellido()+"\n"+
                "Cédula: "+getCedula()+"\n"+
                "Fecha de Nacimiento: "+getFechaNac()+"\n"+
                "Dirección: "+getDireccion()+"\n"+
                "Teléfono: "+getTeléfono()+"\n"+
                "Correo Electrónico: "+getCorreo()+"\n"+
                "Estado del Miembro del Equipo: "+getEstadoME();
    }
    
    
}
