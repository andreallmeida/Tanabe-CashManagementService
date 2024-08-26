
const cds = require('@sap/cds');
const { FileHeader, FileContent } = cds.entities;

module.exports = cds.service.impl(async function () {

  // Constants for DB Conection / Entities
  const db = await cds.connect.to('db');
  const dbe = db.entities;

  //
  // Action Call :: fileUpload
  // Action to SAVE Uploaded file inside Database Table
  //
  this.on('fileUpload', async (req) => {

    // "MOVE-CORRESPONDING" for Internal Variables Based 
    // on informed object "fileDetail"
    const { fileName, fileType, fileContent } = req.data.fileDetail;

    //
    // LOGs
    //
    console.log(`===> Content Received (FileName): ${fileName}`);
    console.log(`===> Content Received (FileContent): ${fileContent}`);

    // Check if File Type is correct
    if (fileType != "text/csv")
      req.error({ code: "400", message: "Invalid File Type" }, );

    // Check if File Content is correct
    if (fileContent === "")
      req.error({ code: "400", message: "Empty file content" });

    // Split Lines for File Imported
    const fileLines = fileContent.split('\n');
    console.log(`===> File Lines Imported Count: ${fileLines.length}`);

    // Fill Items Array based File content
    let itemsArray = [];
    for (let index = 0; index < fileLines.length; index++) {
      const element = fileLines[index];

      let itemElement = {};
      itemElement.ID = cds.utils.uuid();
      itemElement.fileline = index + 1;
      itemElement.content = element;
      itemsArray.push(itemElement);
    }

    // Object for INSERT Header with Content values (Deep Structure)
    let dynRecord =
    {
      "ID": cds.utils.uuid(),
      "fileName": fileName,
      "fileType": fileType,
      "items": itemsArray
    };
    await INSERT.into(dbe.FileHeader).entries(dynRecord);

    //
    // LOGs
    //
    console.log(`===> File content saved at database with GUID : ${dynRecord.ID} ` );
    return { success: false, message: `File ${fileName} uploaded successfully.` };
  })

});
