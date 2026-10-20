# Liquidación de gastos (iPhone + PC)

## Qué estaba fallando
1. **No subía el CSV de Revolut**: el lector de CSV tenía mal escritos los saltos de línea, así que nunca separaba las filas.
2. **No descargaba el Excel**: dependía de cargar ExcelJS desde internet (CDN) y de leer la plantilla por red, y en iPhone la descarga automática de archivos falla en apps instaladas.
3. **No enviaba por mail**: `mailto:` no puede adjuntar archivos.

## Qué hace ahora
- ExcelJS y tu plantilla (`1__Plantilla_de_gastos.xlsx`) van **dentro** de la app: funciona sin internet y también abriendo `index.html` directamente en el PC.
- Importa el CSV de Revolut: solo pagos con tarjeta completados (omite recargas, transferencias e ingresos), te los muestra para marcar cuáles son gasto de empresa y en qué columna van (peaje, parking, dietas…). Evita duplicados.
- **Descargar Excel**: en PC descarga directo; en iPhone abre el menú de compartir («Guardar en Archivos»).
- **Enviar por correo**: en iPhone y en navegadores compatibles abre el menú de compartir con el Excel ya adjunto (elige Mail/Outlook). Si no es posible, descarga el archivo y abre el correo para que lo adjuntes.
- Copia de seguridad / restaurar (.json) para pasar los gastos de un dispositivo a otro.

## Cómo usarla
- **PC**: abre `index.html` en Chrome/Edge.
- **iPhone**: sube TODA la carpeta a un alojamiento HTTPS (GitHub Pages, Netlify, Cloudflare Pages…), ábrela en Safari → Compartir → «Añadir a pantalla de inicio».

## Seguridad
Política CSP estricta, sin librerías desde CDN, datos importados mostrados como texto, todo guardado solo en el dispositivo (comentado en `index.html`).

## Publicar en GitHub Pages (sin instalar nada)
1. Crea cuenta en github.com → «New repository». Nombre poco evidente (p. ej. `lg-8k2x`), visibilidad Public (Pages gratis exige público).
2. «uploading an existing file» → arrastra TODO el contenido de la carpeta `liquidacion_gastos_webapp` (index.html en la raíz) → Commit changes.
3. Settings → Pages → Source: «Deploy from a branch» → rama `main`, carpeta `/ (root)` → Save.
4. En 1-2 minutos aparece la dirección `https://TUUSUARIO.github.io/NOMBRE-REPO/`.
5. iPhone: Safari → Compartir → «Añadir a pantalla de inicio». PC: abre la dirección (o «Instalar»).
6. Actualizar: en el repositorio, «Add file → Upload files» y sustituye `index.html`.

## Privacidad
- El archivo publicado NO contiene tu nombre ni tu puesto: se escriben en la app y se guardan solo en tu dispositivo.
- Los gastos y el CSV nunca se suben a GitHub: se quedan en el navegador de cada dispositivo.
- Nunca subas al repositorio tu CSV de Revolut ni Excel ya rellenados.
