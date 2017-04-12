/**
 * Created by melan on 2017-02-14 for BIF812 Assignment 1.
 * purpose:  To understand and implement basic Java classes and
 * methods and to test the effectiveness of different concatenation methods.
 * /*I declare that the attached assignment is my own work in accordance with Seneca Academic
 Policy. No part of this assignment has been copied manually or electronically from any other
 source (including web sites) or distributed to other students.
 Name: Melanie Dawe Student ID: 129089157
 */
public class MiniGenBankSeq extends SequenceLoader{
   private String locus;
   private String accession;
   private String definition;
   private String source;

    public String getLocus() {
        if (locus != null) {
            return locus;
        }
        else {
            return "Warning this is a null value";
        }

    }

    public String getAccession() {
        if (accession != null) {
            return accession;
        }
        else {
            return "Warning this is a null value";
        }

    }

    public String getDefinition() {
            if (definition != null) {
                return definition;
            }
            else {
                return "Warning this is a null value";
            }

    }

    public String getSource() {
        if (source != null) {
            return source;
        }
        else {
            return "Warning this is a null value";
        }

    }

    public void setLocus(String locus) {

            this.locus = locus;
    }

    public void setAccession(String accession) {
            this.accession = accession;
        }


    public void setDefinition(String definition) {

            this.definition = definition;
    }

    public void setSource(String source) {
            this.source = source;

    }

    public MiniGenBankSeq() {
    }

    public MiniGenBankSeq(String locus, String accession) {
        this.locus = locus;
        this.accession = accession;
    }

    public MiniGenBankSeq(String locus, String accession, String definition, String source) {
        this.locus = locus;
        this.accession = accession;
        this.definition = definition;
        this.source = source;
    }

    @Override
    public String toString() {
            return "MiniGenBankSeq{" +
                    "locus='" + getLocus() + '\'' +
                    ", accession='" + getAccession() + '\'' +
                    ", definition='" + getDefinition() + '\'' +
                    ", source='" + getSource() + '\'' +
                    '}';


        }
}



