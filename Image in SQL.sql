Use master
CREATE Database PracticeDB
Go

Use PracticeDB
Go

Use PracticeDB
CREATE Table Images(
	image_id			int PRIMARY KEY IDENTITY,
	image_data	varbinary(max),
	file_name	varchar(255) NOT NULL,
	description varchar(max)
);
GO

CREATE PROCEDURE insert_image (
    @imageData VARBINARY(MAX),
    @fileName VARCHAR(255),
    @description VARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO images (image_data, file_name, description)
    VALUES (@imageData, @fileName, @description)
END
GO

DECLARE @imageVar VARBINARY(MAX);
SELECT @imageVar = (SELECT * FROM OPENROWSET(BULK N'C:\Users\ASUS\Pictures\ship.png', SINGLE_BLOB) as image)
EXECUTE insert_image @imageData = @imageVar, @fileName = 'image.jpg', @description = 'A beautiful image';
GO


CREATE PROCEDURE get_image (
    @imageId INT
)
AS
BEGIN
    SELECT image_data, file_name, description
    FROM images
    WHERE image_id = @imageId
END
GO

EXECUTE get_image @imageId = 1;
GO

-- Show the Image in .NET Core
/*
using System.IO;
using System.Drawing;
using (var connection = new SqlConnection(connectionString))
{
    await connection.OpenAsync();

    // Execute the stored procedure to retrieve the image data
    var command = new SqlCommand("get_image", connection)
    {
        CommandType = CommandType.StoredProcedure
    };
    command.Parameters.AddWithValue("@imageId", 1);
    var reader = await command.ExecuteReaderAsync();

    // Read the image data from the reader
    await reader.ReadAsync();
    var imageData = (byte[])reader["image_data"];
    var fileName = (string)reader["file_name"];
    var description = (string)reader["description"];

    // Save the image data to a file
    await File.WriteAllBytesAsync(fileName, imageData);

    // Open the image in an image viewer
    Image.FromFile(fileName).Show();
}


*/

-- Show The Image using ADO.NET
/*

using System.IO;
using System.Drawing;
using (var connection = new SqlConnection(connectionString))
{
    connection.Open();

    // Execute the stored procedure to retrieve the image data
    var command = new SqlCommand("get_image", connection)
    {
        CommandType = CommandType.StoredProcedure
    };
    command.Parameters.AddWithValue("@imageId", 1);
    var reader = command.ExecuteReader();

    // Read the image data from the reader
    reader.Read();
    var imageData = (byte[])reader["image_data"];
    var fileName = (string)reader["file_name"];
    var description = (string)reader["description"];

    // Save the image data to a file
    File.WriteAllBytes(fileName, imageData);

    // Open the image in an image viewer
    Image.FromFile(fileName).Show();
}


*/

--Show the image using Python
/*
import base64
from PIL import Image

# Read the image data from the database
image_data = ...

# Decode the image data
image_data = base64.b64decode(image_data)

# Save the image data to a file
with open('image.jpg', 'wb') as f:
    f.write(image_data)

# Open the image in an image viewer
Image.open('image.jpg').show()

*/

