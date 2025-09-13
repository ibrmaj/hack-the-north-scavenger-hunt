#gQZNTHhrx5CEz3ut4BF7ZQaxNi2xX8g425mPXTijDAeZXFraiqbjpGJ5uFUBmoCKqR7DYBx11TqepEfar2w9h3dthWRaq19tdik1Cp2rvwJn1TRkQ8CQTi2KCBgfDXwzNTRAFSRjKiTjNqHcRa2g3nzKgmQNAWs225YyocMAoR2inTmiX4WHgd2dmhVe1UMdxWD3nCgYWLV1r5Vnz9iCGW58Kv6rgJ2tPAVGL18R9Vuscy1Uaprsu2bujGwLEJ7xurRU7RkGTpzucpAJNT22SMsp5qd54XsQWvQdWZa449uCkcf5DTpxZQSShXBwBjJ9kxvhyQ4wD7kc5AhYitfWv2pyzCJGzD5EbqzwpJvQ5BnF4fkzBKy6sEuoajsoTME5v8FjiF61K7pMxccg6y3KNAgHXWR7MiwLWBsquEjS89edkVovFkEB5gXc8zvzQmGBoEhmTZimqhTiMkynTjSLYngYgPc7GM6ybTLa5gUEScQqU8scDEh6z53Z46PjzaGAVwptNyrx9479zYdqwbTnc8B2tBKmSPNBqTxEnSS8dLZFb1U5T7c7KuHH7XHMUN4BBwKpDiWn38GxPpCXRK3GmLoJ7aYBajc6sJrquLPS2hHCHZwKJJYTfxk9Ar7268kh7hJ7xqyKUyqrStKTkYB75HSZYHCXi4QR3rjj5xaL9tJXDLRe19A8T2mp2w9cScKPt4ftNBXVbeoXNEzupHqpZCBNpDQq7HskkXHQ9oukMNdZQGr5EnLe9ki3u5sfkWsv4M8zpJwQ6VzPT7Dsz4rKEWsV4bgyCgZnhDKifPobJrQmiirbQyUu5hD6ZLkt2LP12Qn5y6N5hb5RmS7nHymaUQUfgEvd2iEhjHVPn3B9DiFvuQYKobm2aeBLWngixZie7f2F6xDHk7s9StDpXDDTYHfDLuQXCiFk4RfVswJPqtU6Z7AdQ7hz7dbysb3KyVDebWWkdvEb6FcF7LxMJ9fQYusFMZKvj91176ey4KcpT7ppqJ1XzzffLkxzCC5zFBw5PX4GTpuUzhAJWRomx5JihxkUTzoKvMVaztw2Sd2tthtUy7X5QtpcyJsWo9tag3NgT4WFYo6SEsVXBxCj3x2K1zyDMW9ZWnGsxYYxUZVLDSNqFna5voC5epwFXXmD9e5pj9oNWncbj6e24MoD8Hh4EQnvxS75BKaREdVc94MJZeLw18oeNcB9RGYvCKqKgFQVGK4t6wK22SeLBCSimbb2ztVRD2rQhFHtmHzf2fPhpCTXEejBVDHvZn8qSaYJdjcjeZobpqRbKbnZ1FQsg9Qyba7AQHXdjP5hKcS9AjbuVnafMFv8oPSt1wYGsQExdn1PKk4rNcbfspybWoEYR9dmNN4phQ7EEoSsG6sWwi3cyDcGiGphr4FW5hLBUj6fB2FbFuDCDo7AG9DCuNqJgn5vtTyBvPx1g9fUxXWDXJSejhuxqMEQ4mmMCeTyzGGLEHFSmoRiU6TRvcvbNj53umgkMPQK24VpNguLhQTvchmLjQ3Bn2AdBsrudZY55a4yLqgy9QLEH6zDeCR9mMTrQqZBvGU28FjqMvK83bUws1qkYNy5EaVFYYcWrpknsqktndcNiUYhEBywh2Xot6TWTcivjxUykJgKDSTteYQJocp3uVb1VQQgRSHTtacjLBr688N76oipTssF97SWj5

# Spiral Encoding Protocol - Ruby Starter Code

## Your Implementation

def solve_spiral_encoding(n)
  return [] unless n.is_a?(Integer) && n > 0

  fibs = generate_fibonacci_sequence(n)
  parts = find_representation(n, fibs)

  # If no exact representation found (shouldn't happen for n > 0 with Zeckendorf),
  # treat it as invalid per the starter comments.
  return [] unless parts.sum == n

  parts.sort
end

# Generate the Fibonacci sequence up to 'limit'
# Example: generate_fibonacci_sequence(10) => [1, 2, 3, 5, 8]
def generate_fibonacci_sequence(limit)
  return [] if limit <= 0
  seq = [1, 2] # using (1, 2) so the visible sequence is 1,2,3,5,8,...
  while seq[-1] + seq[-2] <= limit
    seq << (seq[-1] + seq[-2])
  end
  seq
end

# Optional helper: check if n can be expressed using non-consecutive Fibonacci numbers
# (With Zeckendorf’s theorem, every n > 0 has a unique representation.)
def is_valid_tag?(n)
  return false unless n.is_a?(Integer) && n > 0
  fibs = generate_fibonacci_sequence(n)
  find_representation(n, fibs).sum == n
end

# Find which numbers from the Fibonacci sequence sum to n
# Constraint: no two consecutive Fibonacci numbers can be used.
# Greedy (right-to-left) produces the unique Zeckendorf representation.
def find_representation(n, sequence)
  remaining = n
  result = []
  # Track the last index picked to avoid consecutive picks
  last_idx = Float::INFINITY

  # Walk from largest fib downward
  sequence.each_with_index.to_a.reverse_each do |fib, idx|
    # Skip if taking this 'idx' would be consecutive with the previous taken one
    # (i.e., previous idx == idx + 1).
    next if (last_idx - idx) == 1

    if fib <= remaining
      result << fib
      remaining -= fib
      last_idx = idx
      break if remaining == 0
    end
  end

  # If there’s still remainder, keep scanning down with the same rule
  # (A single pass above usually suffices, but continue just in case.)
  if remaining > 0
    (sequence.length - 1).downto(0) do |idx|
      next if (last_idx - idx) == 1
      fib = sequence[idx]
      if fib <= remaining
        result << fib
        remaining -= fib
        last_idx = idx
        break if remaining == 0
      end
    end
  end

  # If still remaining, continue a simple loop until filled
  while remaining > 0
    # find largest fib <= remaining with index <= last_idx - 2
    allowed_idx = nil
    sequence.each_with_index do |fib, idx|
      next if (last_idx - idx) == 1
      allowed_idx = idx if fib <= remaining
    end
    break if allowed_idx.nil? # no valid pick (shouldn't happen for Zeckendorf)

    fib = sequence[allowed_idx]
    result << fib
    remaining -= fib
    last_idx = allowed_idx
  end

  result
end