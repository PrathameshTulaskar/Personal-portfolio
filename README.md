# Personal Portfolio

Responsive Flutter portfolio app for web, Android, and iOS. Built with Clean Architecture, GetX, resume-backed content, premium portfolio sections, and web SEO files.

## What To Edit

- `lib/data/datasources/portfolio_local_data_source.dart` contains portfolio content from the resume.
- `lib/domain/` contains entities, repository contracts, and use cases.
- `lib/presentation/` contains GetX controllers, pages, and widgets.
- `assets/images/profile.png` is the professional profile photo.
- `assets/documents/Prathamesh_J_Tulaskar_Resume.pdf` is the bundled resume.
- `web/manifest.json` contains the web app install metadata.
- Publish the repository as `personal-portfolio` for this GitHub Pages URL: `https://prathameshtulaskar.github.io/personal-portfolio/`.
- Replace placeholder App Store, demo video, and Google Analytics values when ready.

## Current Features

- Animated hero section with typing roles and profile photo.
- About, skills, projects, live demos, statistics, certifications, experience, resume, blog, AI assistant, contact, settings, and SEO sections.
- GetX dependency injection, controller state, theme toggle, language selector, and local assistant answers.
- Web SEO support through meta tags, structured data, `robots.txt`, and `sitemap.xml`.

## Run Locally

```powershell
flutter run -d chrome
```

For Android or iOS, open the folder in your Flutter editor or run on a connected device.

## Use With GitHub Desktop

1. Open GitHub Desktop.
2. Choose **File > Add local repository**.
3. Select `C:\Users\ptulaskar\Documents\Personal portfolio`.
4. Commit the files.
5. Click **Publish repository** when you are ready to upload it to GitHub.
