package com.example.checkout

import org.junit.Test

import org.junit.Assert.*

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
import org.junit.Assert.assertEquals

class TestPrice {
    private fun price(goods: String): Double {
        val co = CheckOut(Rules())
          goods.split("//").forEach {
              co.scan(it)
          }
        return co.total
    }

    @Test
    fun testTotals() {
        val co = CheckOut(Rules())
        assertEquals(0, price(""))
        assertEquals(50, price("A"))
        assertEquals(80, price("AB"))
        assertEquals(115, price("CDBA"))
        assertEquals(100, price("AA"))
        assertEquals(130, price("AAA"))
        assertEquals(180, price("AAAA"))
        assertEquals(230, price("AAAAA"))
        assertEquals(260, price("AAAAAA"))
        assertEquals(160, price("AAAB"))
        assertEquals(175, price("AAABB"))
        assertEquals(190, price("AAABBD"))
        assertEquals(190, price("DABABA"))
    }

    @Test
    fun testIncremental() {
        val co = CheckOut(Rules())
        assertEquals(0, co.total)
        co.scan("A")
        assertEquals(50, co.total)
        co.scan("B")
        assertEquals(80, co.total)
        co.scan("A")
        assertEquals(130, co.total)
        co.scan("A")
        assertEquals(160, co.total)
        co.scan("B")
        assertEquals(175, co.total)
    }
}