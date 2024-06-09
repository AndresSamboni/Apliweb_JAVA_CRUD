/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.together.manage_hospital.logics;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author Edwin Andrés Samboní Ortiz
 */

// TABLE DEFINITION
@Entity
@Table(name = "tbl_role")

// QUERIES DEFINITION
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblRole.findAll", query = "SELECT t FROM TblRole t"),
    @NamedQuery(name = "TblRole.findByIdRole", query = "SELECT t FROM TblRole t WHERE t.idRole = :idRole"),
    @NamedQuery(name = "TblRole.findByName", query = "SELECT t FROM TblRole t WHERE t.name = :name")
})

// CLASS THAT REPRESENT THE ENTITY
public class TblRole implements Serializable {

    private static final long serialVersionUID = 1L;
    
    // IDENTIFIER OF THE ROLE
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_role")
    private Integer idRole;
    
    // NAME OF THE ROLE
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "name")
    private String name;
    
    // DESCRIPTION OF THE ROLE
    @Lob
    @Size(max = 65535)
    @Column(name = "description")
    private String description;
    
    // RELATION WITH THE MEDICAL STAFF TABLE
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idRole")
    private Collection<TblMedicalStaff> tblMedicalStaffCollection;

    // EMPTY CONSTRUCTOR
    public TblRole() {
    }

    // CONSTRUCTOR BY ID
    public TblRole(Integer idRole) {
        this.idRole = idRole;
    }

    // FULL CONSTRUCTOR
    public TblRole(Integer idRole, String name) {
        this.idRole = idRole;
        this.name = name;
    }

    // GETTER AND SETTER METHODS
    public Integer getIdRole() {
        return idRole;
    }

    public void setIdRole(Integer idRole) {
        this.idRole = idRole;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public Collection<TblMedicalStaff> getTblMedicalStaffCollection() {
        return tblMedicalStaffCollection;
    }

    public void setTblMedicalStaffCollection(Collection<TblMedicalStaff> tblMedicalStaffCollection) {
        this.tblMedicalStaffCollection = tblMedicalStaffCollection;
    }

    // OTHER METHODS
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRole != null ? idRole.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TblRole)) {
            return false;
        }
        TblRole other = (TblRole) object;
        if ((this.idRole == null && other.idRole != null) || (this.idRole != null && !this.idRole.equals(other.idRole))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "co.edu.together.manage_hospital.logic.TblRole[ idRole=" + idRole + " ]";
    }
    
}
