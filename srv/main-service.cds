// srv/fileUploadService.cds

using {tanabe.cashmanagement as my} from '../db/schema';

service FileManagement @(path: '/FileManagement') {
    entity FileHeader  as projection on my.FileHeader;
    entity FileContent as projection on my.FileContent;

    action fileUpload(fileDetail : {
        fileName : String;
        fileType : String;
        fileContent : String;
    })
};

service Transactions @(path: '/Transaction') {
    entity BankTransactions as projection on my.BankTransactions;
};
