use std::fs::File;
use std::io::{BufReader, BufRead, Lines};

pub fn input_lines(filename: &str) -> Lines<impl BufRead> {
    let file = File::open(filename).expect("failed to open input file");
    BufReader::new(file).lines()
}


#[cfg(test)]
mod common_tests {
    use super::*;

    #[test]
    fn can_read_first_line_of_input() {
        assert_eq!(input_lines("input\\day4.txt").next().unwrap().unwrap(), "sayndz zfxlkl attjtww cti sokkmty brx fhh suelqbp");
    }

    #[test]
    fn failed_to_open_input_error() {}
}