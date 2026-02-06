use std::env;
use std::fs;
use std::path::PathBuf;

fn main() {
    let mut args = env::args().skip(1).collect::<Vec<_>>();
    if args.len() != 2 {
        eprintln!("usage: watc <input.wat> <output.wasm>");
        std::process::exit(2);
    }

    let in_path = PathBuf::from(args.remove(0));
    let out_path = PathBuf::from(args.remove(0));

    let src = match fs::read_to_string(&in_path) {
        Ok(v) => v,
        Err(e) => {
            eprintln!("read {} failed: {}", in_path.display(), e);
            std::process::exit(1);
        }
    };
    let wasm = match wat::parse_str(&src) {
        Ok(v) => v,
        Err(e) => {
            eprintln!("parse {} failed: {}", in_path.display(), e);
            std::process::exit(1);
        }
    };
    if let Some(parent) = out_path.parent() {
        if let Err(e) = fs::create_dir_all(parent) {
            eprintln!("mkdir {} failed: {}", parent.display(), e);
            std::process::exit(1);
        }
    }
    if let Err(e) = fs::write(&out_path, wasm) {
        eprintln!("write {} failed: {}", out_path.display(), e);
        std::process::exit(1);
    }
    println!("OK watc {} -> {}", in_path.display(), out_path.display());
}
