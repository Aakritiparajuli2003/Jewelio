const fs = require('fs');
const path = require('path');

function copyRecursiveSync(src, dest) {
    const exists = fs.existsSync(src);
    const stats = exists && fs.statSync(src);
    const isDirectory = exists && stats.isDirectory();
    if (isDirectory) {
        if (!fs.existsSync(dest)) {
            fs.mkdirSync(dest, { recursive: true });
        }
        fs.readdirSync(src).forEach(function (childItemName) {
            copyRecursiveSync(path.join(src, childItemName), path.join(dest, childItemName));
        });
    } else {
        fs.copyFileSync(src, dest);
    }
}

function removeDirSync(dir) {
    if (fs.existsSync(dir)) {
        fs.rmSync(dir, { recursive: true, force: true });
    }
}

async function build() {
    console.log("--- STARTING SIMPLE BUILD ---");
    const root = path.join(__dirname, '..');
    const distPath = path.join(root, 'dist');

    console.log('🧹 Cleaning dist directory...');
    removeDirSync(distPath);
    fs.mkdirSync(distPath, { recursive: true });

    console.log('📂 Copying files to dist...');
    const itemsToCopy = [
        'views',
        'routes',
        'controllers',
        'middleware',
        'public',
        'index.js',
        'firebase.js',
        'package.json',
        '.env.example',
        'README.md'
    ];

    itemsToCopy.forEach(item => {
        const src = path.join(root, item);
        const dest = path.join(distPath, item);
        if (fs.existsSync(src)) {
            if (fs.statSync(src).isDirectory()) {
                copyRecursiveSync(src, dest);
            } else {
                fs.copyFileSync(src, dest);
            }
            console.log(`  - Copied ${item}`);
        } else {
            console.log(`  - Warning: Source ${item} not found`);
        }
    });

    console.log('\n✅ Build completed! Output in /dist');
}

build().catch(err => {
    console.error('❌ Build failed:', err);
    process.exit(1);
});
