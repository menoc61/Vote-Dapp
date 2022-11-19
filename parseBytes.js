//convert back bytes to string
const ethers = require('ethers');

parseBytes = async(args)  => {
    const bytes = args[0];
    const name = ethers.utils.parseBytes32String(bytes);
    console.log(`Name: ${name}`);
}

parseBytes(process.argv.slice(2));