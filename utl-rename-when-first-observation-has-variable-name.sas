Rename when first observation has variable name

github
https://tinyurl.com/ycy89heu
https://github.com/rogerjdeangelis/utl-rename-when-first-observation-has-variable-name

https://tinyurl.com/ybyd92up
https://communities.sas.com/t5/SAS-Data-Management/first-observation-is-variable-name/m-p/511934

INPUT (flatfile)
================

d:/txt/have.txt

Name   Sex Address        Phone
Rachel F   789 Mid County 111-111-1111


EXAMLE OUTPUT
-------------

 WORK.LOG total obs=1

   REC         STATUS

    0     rename sucessfull

 WORK.WANT total obs=1

   NAME     SEX       ADDRESS           PHONE

  Rachel     F     789 Mid County    111-111-1111


PROCESS
=======

   data Log;

     if _n_=0 then do; %let rc=%sysfunc(dosubl('
        filename rens "d:/txt/vhk.txt"; ;
        data WANT;
          infile "d:/txt/have.txt";
          file rens;
          input A $6. +1 B $3. +1 C $14. +1  D : $12.;
          if _n_= 1 then put (_all_) (=);
          else if  _n_ > 1 then output have;
        run;quit;
        '));
     end;

     else do; rec=dosubl('
        proc datasets;
           modify have;
           rename %include rens;
        ;run;quit;
        %let cc=&syserr;
        ');
     end;

     if symgetn('cc')=0 then status="rename sucessfull";
     else status="rename failed";

   run;quit;

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

filename ft15f001 "d:/txt/have.txt";
parmcards4;
Name   Sex Address        Phone
Rachel F   789 Mid County 111-111-1111
;;;;
run;quit;

