    MOV D, 0;

increase:

    INC D;
    CMP D, 5;
    JO increase

decrease:

    DEC D;
    CMP D, 0;
    JZ increase
    JMP decrease

    HLT
