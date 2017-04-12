/**
 * Created by melan on 2017-02-14 for BIF812 Assignment 1.
 * purpose:  To understand and implement basic Java classes and
 * methods and to test the effectiveness of different concatenation methods.
 * /*I declare that the attached assignment is my own work in accordance with Seneca Academic
 Policy. No part of this assignment has been copied manually or electronically from any other
 source (including web sites) or distributed to other students.
 Name: Melanie Dawe Student ID: 129089157
 */

public class UseMiniGeneBankSeq {
    public static void main(String[] args) {
       MiniGenBankSeq s1 = new MiniGenBankSeq();
        System.out.println ("displaying no argument constructor: ");
        System.out.println (s1.toString());
        //Info from https://www.ncbi.nlm.nih.gov/nuccore/NM_000492.3
        System.out.println ("displaying setter method for no-argument constructor:");
        s1.setLocus("NM_000492 6132 bp mRNA linear PRI 15-SEP-2016");
        s1.setAccession("NM_000492");
        s1.setDefinition("Homo sapiens cystic fibrosis transmembrane conductance regulator\n" +
                "            (CFTR), mRNA.");
        s1.setSource("Homo sapiens (human)");
        System.out.println(s1.toString());
        System.out.println("displaying 2args constructor:");
        //Info from https://www.ncbi.nlm.nih.gov/nuccore/DQ915282.1
       MiniGenBankSeq s2 = new MiniGenBankSeq(" DQ915282 209 bp DNA linear MAM 14-JUL-2016, ", "DQ915282");
        System.out.println(s2.toString());
        s2.setDefinition("Sus scrofa Huntingtons disease protein (Huntingtin) gene,\n" +
                "            Huntingtin-9 allele, partial cds");
        s2.setSource("Sus scrofa (pig)");
        System.out.println("Displaying setter method for 2args method");
        System.out.println(s2.toString());
        //Info from https://www.ncbi.nlm.nih.gov/nuccore/NM_032043.2
        System.out.println("Displaying 4args constructor");
        MiniGenBankSeq s3 = new MiniGenBankSeq("NM_032043 8166 bp mRNA linear PRI 07-OCT-2016", "NM_032043", "Homo sapiens BRCA1 interacting protein C-terminal helicase 1\n" +
                "            (BRIP1), mRNA","Homo sapiens (human)" );
        System.out.println(s3.toString());


    }

}
