//convert strings into bytes
const ethers = require('ethers');

createBytes = async(name)  => {
    const candidate = name[0];
    const bytes = ethers.utils.formatBytes32String(candidate);
    console.log(`Bytes: ${bytes}`);
}

createBytes(process.argv.slice(2));