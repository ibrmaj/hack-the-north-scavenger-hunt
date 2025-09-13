## The SHOPPY Cipher Algorithm

The SHOPPY Cipher transforms a product ID into a discount code using Shoppy's signature "chop and enchant" technique:

1. **EXPAND**: Convert the productId to a string and expand it
   - Pad with leading zeros to ensure at least 4 digits
   - Example: 123 → "0123"

2. **CHOP & ROTATE**: Split into pairs and rotate
   - Split into 2-character chunks: "0123" → ["01", "23"]
   - Rotate each chunk by its position (1st chunk by 1, 2nd by 2, etc.)
   - "01" rotate right 1 → "10"
   - "23" rotate right 2 → "23" (no change for 2-char rotate by 2)

3. **ENCHANT**: Apply Shoppy's magical green enchantment
   - XOR each character with bytes from Shopify's green hex code: `#96BF48`
   - Cycle through the hex bytes: 0x96, 0xBF, 0x48

4. **ENCODE**: Convert to allowed characters
   - Map the final result to: "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
   - Take exactly 4 characters for the final code

## Your Task

Implement the SHOPPY Cipher to generate discount codes in format `SAVE-XXXX`.

## Input

- `productId`: A positive integer

## Output

A string in format `SAVE-XXXX` using only allowed characters

## Example Walkthrough

```ruby
productId: 1234

Step 1 - EXPAND: "1234"

Step 2 - CHOP & ROTATE:
Chunks: ["12", "34"]
"12" rotate right 1 → "21"
"34" rotate right 2 → "34"
Result: "2134"

Step 3 - ENCHANT:
'2' (0x32) XOR 0x96 = 0xA4
'1' (0x31) XOR 0xBF = 0x8E

'3' (0x33) XOR 0x48 = 0x7B
'4' (0x34) XOR 0x96 = 0xA2

Step 4 - ENCODE: Map to allowed chars → "SAVE-K9TN"
```
