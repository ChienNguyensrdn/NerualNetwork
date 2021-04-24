Select 
  Io.Employee_Object, Io.Valin1 ,Io.Valout1 ,Io.Valin2 ,Io.Valout2,Io.Valin3 ,Io.Valout3,Io.Valin4 ,Io.Valout4, Io.Wcode,
  Org_Shift.*
From(
select 
      E.Employee_Object,
      Nvl(To_Number(To_Char(Io.Valin1,  'HH24'))*60   +To_Number(To_Char(Io.Valin1,  'MI')),-1)Valin1,  
      Nvl(To_Number(To_Char(Io.Valout1,  'HH24'))*60   +To_Number(To_Char(Io.Valout1,  'MI')),-1) Valout1,  
      Nvl(To_Number(To_Char(Io.Valin2,  'HH24'))*60   +To_Number(To_Char(Io.Valin2,  'MI')),-1)Valin2,  
      Nvl(To_Number(To_Char(Io.Valout2,  'HH24'))*60   +To_Number(To_Char(Io.Valout2,  'MI')) ,-1)Valout2,
      Nvl(To_Number(To_Char(Io.Valin3,  'HH24'))*60   +To_Number(To_Char(Io.Valin3,  'MI')),-1)Valin3,  
      Nvl(To_Number(To_Char(Io.Valout3,  'HH24'))*60   +To_Number(To_Char(Io.Valout3,  'MI')),-1) Valout3,
      Nvl(To_Number(To_Char(Io.Valin4,  'HH24'))*60   +To_Number(To_Char(Io.Valin4,  'MI')),-1)Valin4,  
      Nvl(To_Number(To_Char(Io.Valout4,  'HH24'))*60   +To_Number(To_Char(Io.Valout4,  'MI')),-1) Valout4,
      W.Org_Id,
      Io.Wcode   
  From at_data_inout IO  
  Inner Join Hu_Employee E
    On E.Id = Io.Employee_Id
 Inner Join Hu_Working W On W.Id=Pkg_Function.Workingmax_Bydate(E.Id,Io.Workingday)      
 Where Io.Workingday Between '01-jan-21' And '31-jan-21'   And     Io.Wcode   Is Not Null
 Group By    E.Employee_Object, Io.Valin1 ,Io.Valout1 ,Io.Valin2 ,Io.Valout2,Io.Valin3 ,Io.Valout3,Io.Valin4 ,Io.Valout4, Io.Wcode ,W.Org_Id
 
 )IO
Inner Join (
      Select T1.HC4_Hours_Start,
       HC7E_Hours_Start,
       HC6_Hours_Start,
       HC5_Hours_Start,
       HC7B_Hours_Start,
       HC1DK_Hours_Start,
       HC2DK_Hours_Start,
       HC8_Hours_Start,
       HC7C_Hours_Start,
       HC7G_Hours_Start,
       HC7F_Hours_Start,
       HC7D_Hours_Start,
       HC7A_Hours_Start,
       HC7_Hours_Start,
       HC_Hours_Start,
       CA1_Hours_Start,
       CA2_Hours_Start,
       CA3_Hours_Start,
       HC3_Hours_Start,
       HC2_Hours_Start,
       HCDK_Hours_Start,
       HC1_Hours_Start,
       T2.*
  From (Select *
          From (Select S.Org_Id,
            Nvl(To_Number(To_Char(Sh.Hours_Start,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Start,  'MI')) ,-1)Hours_Start,
            Sh.Code As Code
                  From At_Org_Shift S
                 Inner Join At_Shift Sh
                    On Sh.Code = S.Shift_Code)
        Pivot(Max(Hours_Start)
           For Code In('HC4' HC4_Hours_Start,
                      'HC7E' HC7E_Hours_Start,
                      'HC6' HC6_Hours_Start,
                      'HC5' HC5_Hours_Start,
                      'HC7B' HC7B_Hours_Start,
                      'HC1DK' HC1DK_Hours_Start,
                      'HC2DK' HC2DK_Hours_Start,
                      'HC8' HC8_Hours_Start,
                      'HC7C' HC7C_Hours_Start,
                      'HC7G' HC7G_Hours_Start,
                      'HC7F' HC7F_Hours_Start,
                      'HC7D' HC7D_Hours_Start,
                      'HC7A' HC7A_Hours_Start,
                      'HC7' HC7_Hours_Start,
                      'HC' HC_Hours_Start,
                      'CA1' CA1_Hours_Start,
                      'CA2' CA2_Hours_Start,
                      'CA3' CA3_Hours_Start,
                      'HC3' HC3_Hours_Start,
                      'HC2' HC2_Hours_Start,
                      'HCDK' HCDK_Hours_Start,
                      'HC1' HC1_Hours_Start))) T1
 Inner Join (Select *
               From (Select S.Org_Id,
                            Case When (To_Number(To_Char(Sh.Hours_Stop,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Stop,  'MI')))  -
                              (To_Number(To_Char(Sh.Hours_Start,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Start,  'MI'))) <0 Then 
                              Nvl( (To_Number(To_Char(Sh.Hours_Stop,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Stop,  'MI')))  -
                              (To_Number(To_Char(Sh.Hours_Start,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Start,  'MI')))
                              +1440  ,-1)
                              Else
                              Nvl(   (To_Number(To_Char(Sh.Hours_Stop,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Stop,  'MI')))  -
                              (To_Number(To_Char(Sh.Hours_Start,  'HH24'))*60   +To_Number(To_Char(Sh.Hours_Start,  'MI')))    ,-1)
                              End Hours_Stop,
                            Sh.Code As Code
                       From At_Org_Shift S
                      Inner Join At_Shift Sh
                         On Sh.Code = S.Shift_Code)
             Pivot(Max(Hours_Stop)
                For Code In('HC4' HC4_Hours_Stop,
                           'HC7E' HC7E_Hours_Stop,
                           'HC6' HC6_Hours_Stop,
                           'HC5' HC5_Hours_Stop,
                           'HC7B' HC7B_Hours_Stop,
                           'HC1DK' HC1DK_Hours_Stop,
                           'HC2DK' HC2DK_Hours_Stop,
                           'HC8' HC8_Hours_Stop,
                           'HC7C' HC7C_Hours_Stop,                                                 
                           
                           'HC7G' HC7G_Hours_Stop,
                           'HC7F' HC7F_Hours_Stop,
                           'HC7D' HC7D_Hours_Stop,
                           'HC7A' HC7A_Hours_Stop,
                           'HC7' HC7_Hours_Stop,
                           'HC' HC_Hours_Stop,
                           'CA1' CA1_Hours_Stop,
                           'CA2' CA2_Hours_Stop,
                           'CA3' CA3_Hours_Stop,
                           'HC3' HC3_Hours_Stop,
                           'HC2' HC2_Hours_Stop,
                           'HCDK' HCDK_Hours_Stop,
                           'HC1' HC1_Hours_Stop))) T2
    On T1.Org_Id = T2.Org_Id
)Org_Shift On  Org_Shift.Org_Id=IO.Org_Id
Order by   Io.Employee_Object, Io.Valin1;
