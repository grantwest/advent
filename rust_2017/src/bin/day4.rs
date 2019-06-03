mod advent_common;
use advent_common::*;

fn main() {
    println!("Part1: {}", part1());
    println!("Part2: {}", part2());
}

fn part1() -> usize {
    input_lines("input\\day4.txt")
        .map(|line| line.unwrap())
        .filter(|passphrase| !contains_duplicates(passphrase))
        .count()
}

fn part2() -> usize {
    input_lines("input\\day4.txt")
        .map(|line| line.unwrap())
        .filter(|passphrase| !contains_anagrams(passphrase))
        .count()
}

extern crate itertools;
use itertools::Itertools;
fn contains_duplicates(passphrase: &str) -> bool {
    let total_words  = passphrase.split_whitespace().count();
    let unique_words = passphrase.split_whitespace().unique().count();
    total_words != unique_words
}

use std::iter::{Iterator, FromIterator};
fn contains_anagrams(passphrase: &str) -> bool {
    let decomposed_words = passphrase
        .split_whitespace()
        .map(|w| String::from_iter(w.chars().sorted()))
        .collect_vec();
    let total_words = decomposed_words.len();
    let unique_words = decomposed_words.iter().unique().count();
    total_words != unique_words
}

#[cfg(test)]
mod day4_tests {
    use super::*;

    #[test]
    fn contains_duplicates_test() {
        assert_eq!(contains_duplicates(""), false);
        assert_eq!(contains_duplicates("hi"), false);
        assert_eq!(contains_duplicates("hi bye"), false);
        assert_eq!(contains_duplicates("hi bye hi"), true);
    }

    #[test]
    fn contains_anagrams_test() {
        assert_eq!(contains_anagrams(""), false);
        assert_eq!(contains_anagrams("abc def"), false);
        assert_eq!(contains_anagrams("abc cba"), true);
    }
}