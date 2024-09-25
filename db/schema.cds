// db/schema.cds

namespace tanabe.cashmanagement;

using {
    cuid,
    managed
} from '@sap/cds/common';

//
// Entity: FileHeader
//
@readonly
entity FileHeader : cuid, managed {
    fileName : String(255); // Uplaodade File Name
    fileType : String(255); // Uplaodade File Name
    items    : Composition of many FileContent
                   on items.header = $self;
}


//
// Entity: FileContent
//
@readonly
entity FileContent : cuid, managed {
    fileline : Integer64;
    content  : String;
    header   : Association to FileHeader;
}

//
// Entity: bankTransaction
//
@odata.draft.enabled
@Capabilities.UpdateRestrictions.Updatable : true
@Capabilities.InsertRestrictions.Insertable: true
@Capabilities.DeleteRestrictions.Deletable : true
@Capabilities.ReadRestrictions.Readable    : true
entity BankTransaction : cuid, managed {

    paymentDate            : Date;
    cardFlag               : Association to MDCardFlag;
    cardNumber             : String;
    modality               : String;
    terminalNumber         : Integer64;
    comercialInstitute     : Integer64;
    grossValue             : Double;
    netValue               : Double;
    uniqueSequentialNumber : Integer64;
    authorizationNumber    : Integer64;
    currentPortion         : String;
    foreignCard            : Boolean;
}

// MasterData for CardFlags
@sap.common.CodeList
entity MDCardFlag : cuid, managed {
        code        : Integer;
        description : String;
}
