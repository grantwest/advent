extern crate itertools;

mod advent_common;
use advent_common::*;
use itertools::Itertools;
use std::collections::HashSet;

fn main() {
    println!("Part1: {}", part1());
    println!("Part2: {}", part2());
}

fn part1() -> i32 {
    let (iterations_before_first_duplicate, _) = find_reallocation_loop(&input());
    iterations_before_first_duplicate
}

fn part2() -> i32 {
    let (_, first_duplicate) = find_reallocation_loop(&input());
    let (loop_length, _) = find_reallocation_loop(&first_duplicate);
    loop_length
}

fn input() -> Vec<i32> {
    input_line("input\\day6.txt")
        .split_whitespace()
        .map(|n| n.parse::<i32>().unwrap())
        .collect_vec()
}

fn find_reallocation_loop(bank: &Vec<i32>) -> (i32, Vec<i32>) {
    let mut seen = HashSet::new();
    let mut prev = bank.clone();
    let mut count = 0;
    loop {
        count += 1;
        let next = reallocate(&prev);
        seen.insert(prev);
        if seen.contains(&next) {
            return (count, next);
        }
        prev = next;
    }
}

fn reallocate(bank: &Vec<i32>) -> Vec<i32> {
    let max_val = *bank.iter().max().unwrap();
    let (max_idx, _) = bank.iter().find_position(|i| **i == max_val).unwrap();

    let mut result = bank.clone();
    *result.get_mut(max_idx).unwrap() = 0;

    let mut rem = max_val;
    let mut i = (max_idx + 1) % bank.len();
    while rem > 0 {
        *result.get_mut(i).unwrap() += 1;
        rem -= 1;
        i = (i + 1) % bank.len();
    }
    result
}

#[cfg(test)]
mod day6_tests {
    use super::*;

    #[test]
    fn find_loop_test() {
        let bank = vec![0, 2, 7, 0];
        assert_eq!(find_reallocation_loop(&bank), (5, vec![2, 4, 1, 2]));
    }

    #[test]
    fn reallocate_test() {
        assert_eq!(reallocate(&vec![0, 2, 7, 0]), vec![2, 4, 1, 2]);
        assert_eq!(reallocate(&vec![2, 4, 1, 2]), vec![3, 1, 2, 3]);
        assert_eq!(reallocate(&vec![3, 1, 2, 3]), vec![0, 2, 3, 4]);
        assert_eq!(reallocate(&vec![0, 2, 3, 4]), vec![1, 3, 4, 1]);
        assert_eq!(reallocate(&vec![1, 3, 4, 1]), vec![2, 4, 1, 2]);
    }

}