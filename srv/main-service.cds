// srv/fileUploadService.cds

using {tanabe.cashmanagement as my} from '../db/schema';


// File Management Entity
service FileManagement @(path: '/FileManagement') {
    entity FileHeader  as projection on my.FileHeader;
    entity FileContent as projection on my.FileContent;

    action fileUpload(fileDetail : {
        fileName   : String;
        fileType   : String;
        fileContent: String;
    })
}

// BankTransaction Entity
service BankTransaction @(path: '/BankTransaction') {
    entity BankTransaction as projection on my.BankTransaction;
};
