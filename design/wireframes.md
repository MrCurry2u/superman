Wireframes & UX Flows — Draft

Goal: concise screen-by-screen flows to guide clickable prototype creation.

1) Launch / Login Flow
- Screen: Launch / branding splash
- Screen: Case selection (if multiple cases) or Onboarding (first-run)
- Screen: Biometric prompt (OS dialog) with fallback passcode setup
- Screen: 2FA enrollment (optional, email/SMS)

2) Case Overview (Default landing after auth)
- Top: Case title, status, quick stats (events today, unread items)
- Primary area: Live Case Feed (scrollable timeline)
- Bottom nav: Overview / Map / Vault / Messages / Settings

3) Live Case Feed (Core)
- Item: Timestamp (14:02) — short text ("Subject arrived at location")
- Attachment thumbnail(s): tap to expand (photo viewer / video player)
- Location pin: tap opens map focused on that event
- Action: Flag / Comment (for client to ask investigator)

4) Attachment Viewer
- Full-screen image/video
- Metadata panel: timestamp, GPS coords, altitude, uploader, SHA-256 hash
- Button: "Add to Vault" (client request) or "Download" (if allowed)

5) Vault
- Filter by type (PDFs, Videos, Affidavits)
- Secure download with short-lived signed URLs
- Audit trail per file with view/download timestamps

6) Interactive Evidence Map
- Map with breadcrumb polyline; time-slider or play/pause for playback
- List view sync: selecting a breadcrumb highlights feed items for the same timeframe
- Export button (GeoJSON / KML)

7) Settings / Legal & Consent
- View consent documents, sign affidavits (upload signed PDF)
- Data retention preferences and export request

Recommended Components (FlutterFlow)
- Authentication: Use platform biometric widgets + custom passcode forms.
- Timeline: Repeating `ListView` with card widgets and lazy-loading.
- Map: Embed Mapbox or Google Maps via custom code component if needed.
- File storage: Use REST calls to Supabase/Xano for uploads; show progress indicators.

Data Model (minimal)
- Case: id, title, client_id, investigator_id, created_at
- Event: id, case_id, timestamp, summary_text, location{lat,lng,alt}, attachments[]
- Attachment: id, event_id, filename, mime, storage_path, sha256, uploader_id, uploaded_at
- VaultFile: id, case_id, filename, storage_path, mime, encrypted:boolean, uploaded_by, uploaded_at

Next steps / Deliverables
- Create clickable Figma screens from these flows OR build screens in FlutterFlow directly.
- Produce user stories & acceptance criteria from each screen (optional).

Which prototype would you like first: `Figma` clickables or `FlutterFlow` screens?