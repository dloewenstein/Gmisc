library(testthat)

context("boxGrob")

test_that("Box auto width", {
  A <- boxGrob("A") %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  AA <- boxGrob("AA") %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  expect_lt(A, AA, label = "Box width should be defined from the width of the text")

  A <- boxPropGrob("A", "A", "A", prop=.5) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  AA <- boxPropGrob("AA", "AA", "AA", prop=.5) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  expect_lt(A, AA, label = "Prop box width should be defined from the width of the text")

  A <- boxPropGrob("AA", "AA", "AA", prop=.5) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  AA <- boxPropGrob("AA", "AA", "AA", prop=.2) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  expect_lt(A, AA, label = "Prop box width should be defined from the width of the text in the smallest box")
})

test_that("Box set width", {
  A <- boxGrob("A", width = unit(10, "mm")) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  AA <- boxGrob("AA", width = unit(10, "mm")) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  expect_equal(A, AA, label = "Box width should be defined from the width")

  A <- boxPropGrob("A", "A", "A", prop=.5, width = unit(10, "mm")) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  AA <- boxPropGrob("AA", "AA", "AA", prop=.5, width = unit(10, "mm")) %>% 
    grobWidth %>% 
    convertX(unitTo = "mm", valueOnly = TRUE)
  expect_equal(A, AA, label = "Prop box width should be defined from the width")
})

test_that("Box auto height", {
  A <- boxGrob("A") %>% 
    grobHeight %>% 
    convertY(unitTo = "mm", valueOnly = TRUE)
  AA <- boxGrob("A\nA") %>% 
    grobHeight %>% 
    convertY(unitTo = "mm", valueOnly = TRUE)
  expect_lt(A, AA, label = "Box height should be defined from the width of the text")
  
  A <- boxPropGrob("A", "A", "A", prop=.5) %>% 
    grobHeight %>% 
    convertY(unitTo = "mm", valueOnly = TRUE)
  AA <- boxPropGrob("A\nA", "AA", "AA", prop=.5) %>% 
    grobHeight %>% 
    convertY(unitTo = "mm", valueOnly = TRUE)
  expect_lt(A, AA, label = "Prop box height should be defined from the width of the text")
})

test_that("Box adjustment and coord consistency", {
  txt <- "AAAAAAAAAA\n  - BBBB"
  bx1 <- boxGrob(txt, x=.8)
  bx2 <- boxGrob(txt, 
                 x = coords(bx1)$left, 
                 bjust="left")
  diff <- sum(sapply(coords(bx1), function(x) convertUnit(x, unitTo = "npc", valueOnly = TRUE)) -
                sapply(coords(bx2), function(x) convertUnit(x, unitTo = "npc", valueOnly = TRUE)))
  
  expect_equal(diff, 0)
})
