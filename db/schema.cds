// db/schema.cds

namespace tanabe.cashmanagement;

using { cuid, managed } from '@sap/cds/common';

//
// Entity: FileHeader
//
@readonly
entity FileHeader : cuid, managed{
    fileName         : String(255); // Uplaodade File Name
    fileType         : String(255); // Uplaodade File Name
    items            : Composition of many FileContent on items.header = $self;
}


//
// Entity: FileContent
//
@readonly
entity FileContent  : cuid, managed{
    fileline         : Integer64;
    content          : String; 
    header           : Association to FileHeader;
}
