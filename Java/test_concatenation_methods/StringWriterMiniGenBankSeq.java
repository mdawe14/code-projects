/**
 * Created by melan on 2017-02-14 for BIF812 Assignment 1.
 * purpose:  To understand and implement basic Java classes and
 * methods and to test the effectiveness of different concatenation methods.
 * /*I declare that the attached assignment is my own work in accordance with Seneca Academic
 Policy. No part of this assignment has been copied manually or electronically from any other
 source (including web sites) or distributed to other students.
 Name: Melanie Dawe Student ID: 129089157
 */

import java.io.StringWriter;

public class StringWriterMiniGenBankSeq extends MiniGenBankSeq {

    @Override
    public void concatenate(String s, int times){
        StringWriter sWriter= new StringWriter();
        for(int i=0; i<times; i++){
            sWriter.append(s);

        }
    }

}