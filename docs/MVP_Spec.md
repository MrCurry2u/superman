Phase 1 — MVP Scope & Success Criteria

Overview
- Objective: Deliver a secure client-facing app that gives clients real-time visibility into investigative activity ("passenger seat").
- Target platforms: iOS and Android (native mobile via Flutter / FlutterFlow).
- Backend: Supabase or Xano for secure storage, authentication, and serverless functions.
- Primary users: Clients (private individuals / corporations) and Investigators.

Core Features (Must-Have)
1. Secure Biometric Login
  - FaceID / TouchID on iOS; Fingerprint / Face unlock on Android via platform biometrics.
  - Fallback: Strong passcode + 2FA via email/SMS for device change.
  - Local keychain / secure enclave storage of auth tokens; no raw biometric data stored.

2. Live Case Feed
  - Scrollable, timestamped timeline (reverse-chron) per case: time, short event text, attachments (photo/video), location pin.
  - Offline caching of newest N entries; background sync.
  - Push notifications for critical events (e.g., new signed affidavit uploaded).

3. The Vault
  - Encrypted storage for PDFs, videos, affidavits.
  - Role-based access (client-only view vs investigator full access).
  - Audit log with per-file hashing for chain-of-custody.

4. Interactive Evidence Map
  - Map showing GPS breadcrumbs with timestamped markers and playback controls.
  - Exportable evidence (GeoJSON/KML) and printable timeline for court.

Security & Legal Constraints (Must-Meet)
- Data encryption: TLS in transit; AES-256 at rest.
- Key management: Use managed KMS (Supabase secrets, or external KMS) and device keychain for local keys.
- Chain-of-custody: Per-file SHA-256 hashes logged immutably (backend) with timestamps and uploader identity.
- Privacy/Consent: Features that record location or audio must have explicit documented consent flows; include recording disclaimers.
- Biometric data: Never store raw biometric templates; use platform APIs (Secure Enclave / Keystore) only.
- Jurisdictional: Consult counsel for cross-border surveillance and admissibility requirements.

Success Criteria (KPIs)
- Functionality: Client can view a case’s latest 7 days of events and open attachments without errors (95% success target).
- Security: No plaintext sensitive files on server; all stored files encrypted and hashed.
- Performance: Timeline loads <2s on 4G for 50 entries; map playback smooth at 1x speed for 1 hour of breadcrumbs.
- Usability: Net Promoter Score (NPS) >= 40 after pilot; onboarding completion rate >= 90%.

Assumptions & Constraints
- Investigators have separate investigator app or role with elevated permissions.
- High-res video storage may incur additional cost; initial MVP limits retention or stores low-res previews in the Vault.
- Integrations (OSINT, Chainalysis) are Phase 2+; MVP focuses on client transparency features.

MVP Timeline (Suggested)
- Week 0: Finalize legal checklist and data model.
- Week 1–2: Authentication, vault schema, basic file upload/download.
- Week 3: Live Case Feed UI + offline caching.
- Week 4: Evidence Map + Geo export.
- Week 5: QA, pilot with 1 client, and iterate.

Deliverables
- `docs/MVP_Spec.md` (this file)
- Clickable wireframes for login, case feed, vault, and map (next).
- Minimal backend: secure file store + timeline API endpoints.

Open Questions
- Which backend do you prefer: `Supabase` (Postgres, storage, auth) or `Xano` (no-code backend)?
- Will investigators use the same mobile app or a separate web/desktop investigator console?

Contact / Next
- I can convert these into user stories and a FlutterFlow prototype next. Which should I create: clickable Figma wireframes or FlutterFlow screens?