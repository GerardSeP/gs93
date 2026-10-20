# Guía: tu dominio + cuentas + gastos guardados (PC y móvil)

Resultado: abres `https://gastos.tudominio.com`, haces login y ves tus gastos tanto en el PC como en el iPhone.
Necesitas: tu dominio, la cuenta de GitHub (ya la tienes) y una cuenta gratuita en Supabase.
Orden: A → B → C → D → E → F. Tiempo aproximado: 30-40 minutos.

---------------------------------------------------------------
## A. Crear la base de datos (Supabase)
1. Entra en https://supabase.com → «Start your project» → crea la cuenta (puedes entrar con GitHub).
2. «New project». Nombre: `gastos`. Contraseña de la base de datos: invéntala y GUÁRDALA (no se usa en la app). Región: una de Europa. Plan: Free.
3. Espera 1-2 minutos a que termine de crearse.
4. Menú izquierdo → **SQL Editor** → «New query». Abre el archivo `supabase_setup.sql` de esta carpeta, copia TODO su contenido, pégalo y pulsa **Run**. Debe decir «Success».
   (Esto crea la tabla y las reglas que impiden que un usuario vea los datos de otro.)
5. Menú izquierdo → **Authentication → URL Configuration**:
   - Site URL: `https://gastos.tudominio.com` (cambia por tu dirección real).
   - Redirect URLs → Add URL: `https://gastos.tudominio.com/**`
   Guarda.
6. Copia dos datos del proyecto: **Project Settings → API** (o el botón «Connect»):
   - **Project URL** (algo como `https://abcdxyz.supabase.co`)
   - La **clave pública** (se llama «anon public» o «publishable»).
   ⚠️ NUNCA uses ni copies la clave «service_role» o «secret»: esa da acceso total y no debe ir en la app.

## B. Poner esos datos en la app
1. Abre `config.js` de esta carpeta con el Bloc de notas.
2. Pega la Project URL entre las comillas de `SUPABASE_URL` y la clave pública en `SUPABASE_ANON_KEY`. Guarda.

## C. Subir la app a GitHub
1. En tu repositorio `gs93` → **Add file → Upload files**.
2. Arrastra TODOS los archivos de esta carpeta (index.html, config.js, sw.js, manifest.webmanifest, icon.svg, apple-touch-icon.png…) y **Commit changes**. Sustituyen a los anteriores.
   No subas supabase_setup.sql ni esta guía si no quieres (no hacen falta en la web).

## D. Conectar tu dominio
Lo más fácil es usar un **subdominio** (por ejemplo `gastos.tudominio.com`).
1. GitHub → repositorio → **Settings → Pages → Custom domain**: escribe `gastos.tudominio.com` → Save.
   (GitHub creará un archivo llamado `CNAME` en el repositorio: NO lo borres.)
2. En el panel donde gestionas el dominio (el registrador o DNS) añade un registro:
   - Tipo: **CNAME**
   - Nombre / Host: **gastos**
   - Valor / Destino: **gerardsep.github.io**
3. Espera de unos minutos a unas horas. Cuando GitHub lo valide, marca **Enforce HTTPS** en Settings → Pages.

## E. Crear tu usuario (y cerrar el registro)
1. Supabase → **Authentication → Users → Add user → Create new user**: tu correo y una contraseña de 12+ caracteres; marca confirmar el correo automáticamente si te lo ofrece.
2. Si la app es solo para ti: **Authentication → Sign In / Providers** (el nombre del menú puede variar) → Email → desactiva «Allow new users to sign up». Así nadie más puede crearse una cuenta.
   Si quieres que otras personas tengan la suya, déjalo activado: cada una verá solo sus propios gastos.

## F. Usarlo
1. Abre `https://gastos.tudominio.com` → entra con tu correo y contraseña.
2. iPhone: Safari → Compartir → «Añadir a pantalla de inicio». PC: abre la misma dirección.
3. Cualquier cambio se guarda solo (arriba verás «Sincronizado ✓»). Al abrir en otro dispositivo, se cargan tus datos.

---------------------------------------------------------------
## Cosas importantes
- **Plan gratuito de Supabase:** si no entras en una semana, el proyecto se pausa. Tus datos no se pierden: en el panel de Supabase pulsa «Restore project». Mientras esté pausado, la app usa la copia guardada en el dispositivo.
- **Privacidad:** cada usuario solo puede leer su propia fila (reglas RLS). Quien administra el proyecto de Supabase (tú) podría ver los datos desde el panel. El extracto bancario CSV nunca se sube: se lee en tu dispositivo y solo se guardan los gastos que añades.
- **Copia de seguridad:** el botón «Copia de seguridad» sigue funcionando; úsalo de vez en cuando.
- **Varios dispositivos a la vez:** gana el último cambio guardado. Evita editar en el PC y el móvil a la vez.
- **Contraseña olvidada:** «Olvidé la contraseña» en la pantalla de login te manda un enlace al correo.
