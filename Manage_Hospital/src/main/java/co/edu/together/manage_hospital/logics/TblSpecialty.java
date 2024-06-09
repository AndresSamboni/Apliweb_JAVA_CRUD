/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.together.manage_hospital.logics;

import jakarta.persistence.Basic;
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
@Table(name = "tbl_specialty")

// QUERIES DEFINITION
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblSpecialty.findAll", query = "SELECT t FROM TblSpecialty t"),
    @NamedQuery(name = "TblSpecialty.findByIdSpecialty", query = "SELECT t FROM TblSpecialty t WHERE t.idSpecialty = :idSpecialty"),
    @NamedQuery(name = "TblSpecialty.findByName", query = "SELECT t FROM TblSpecialty t WHERE t.name = :name")
})

// CLASS THAT REPRESENT THE ENTITY
public class TblSpecialty implements Serializable {

    private static final long serialVersionUID = 1L;
    
    // IDENTIFIER OF THE SPECIALTY
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_specialty")
    private Integer idSpecialty;
    
    // NAME OF THE SPECIALTY
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "name")
    private String name;
    
    // DESCRIPTION OF THE SPECIALTY
    @Lob
    @Size(max = 65535)
    @Column(name = "description")
    private String description;
    
    // RELATION WITH THE MEDICAL STAFF TABLE
    @OneToMany(mappedBy = "idSpecialty")
    private Collection<TblMedicalStaff> tblMedicalStaffCollection;

    // EMPTY CONSTRUCTOR
    public TblSpecialty() {
    }

    // CONSTRUCTOR BY ID
    public TblSpecialty(Integer idSpecialty) {
        this.idSpecialty = idSpecialty;
    }

    // FULL CONSTRUCTOR
    public TblSpecialty(Integer idSpecialty, String name) {
        this.idSpecialty = idSpecialty;
        this.name = name;
    }

    // GETTER AND SETTER METHODS
    public Integer getIdSpecialty() {
        return idSpecialty;
    }

    public void setIdSpecialty(Integer idSpecialty) {
        this.idSpecialty = idSpecialty;
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
        hash += (idSpecialty != null ? idSpecialty.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TblSpecialty)) {
            return false;
        }
        TblSpecialty other = (TblSpecialty) object;
        if ((this.idSpecialty == null && other.idSpecialty != null) || (this.idSpecialty != null && !this.idSpecialty.equals(other.idSpecialty))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "co.edu.together.manage_hospital.logic.TblSpecialty[ idSpecialty=" + idSpecialty + " ]";
    }
    
}
