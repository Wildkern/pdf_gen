Flutter Resume Generator
Overview

The Flutter Resume Generator is a customizable web app built with Flutter. It allows users to create, view, and modify resumes dynamically using Riverpod for state management and the pdf package for generating PDFs. Users can also upload an existing PDF to customize its layout and content.
Features

    Dynamic Resume Customization:
        Adjust font size using a slider.
        Change font color and background color with a color picker.
    PDF Generation:
        Real-time preview of the customized resume.
        Export resumes in PDF format.
    Upload and Customize Existing PDFs:
        Upload any PDF file for customization.
        Regenerate PDFs with applied changes.
    Responsive Design:
        Works seamlessly on desktop browsers as a Flutter web app.

Technologies Used

    Flutter: Frontend framework for building web apps.
    Riverpod: State management.
    pdf: PDF generation in Dart.
    printing: Printing and PDF previewing.
    file_picker: For selecting and uploading PDF files.

Screenshots

Home Screen
![Screenshot from 2025-01-27 15-02-06](https://github.com/user-attachments/assets/68b73346-ac4e-46df-ac30-22689eda4039)

How to Run the Project

    Clone the Repository:

git clone https://github.com/<your-username>/flutter-resume-generator.git

Navigate to the Project Directory:

cd flutter-resume-generator

Install Dependencies:

flutter pub get

Run the App:

    flutter run -d chrome

Future Enhancements

    Add predefined resume templates.
    Support additional file formats for upload and export.
    Include drag-and-drop functionality for arranging resume sections.

Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue for any bugs or feature requests.
