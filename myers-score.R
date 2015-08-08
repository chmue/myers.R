# Myers score computation in R
# Copyright © 2015 Christian Mueller
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

library("dplyr")

myers <- function(target, freq, bin_start, bin_size, na_omit = FALSE) {
  d <- data.frame(target = target, freq = freq)
  d_filter <- seq(bin_start, bin_start + bin_size + 10 - 2)
  if (!all(d_filter %in% target)) stop("Bin setup exceeds available data.")
  d <- d %>%
    filter(target %in% d_filter) %>%
    arrange(target) %>%
    mutate(lastdigit = target %% 10, wgt = c(1:9, rep(10, bin_size - (10 - 1)), 9:1))

  if (na_omit) d <- na.omit(d)

  group_by(d, lastdigit) %>%
    summarise(freq = sum(freq * wgt)) %>%
    mutate(
      freq = freq / sum(freq),
      score = (freq * 100) - 10,
      score = abs(score)
    ) %>%
    summarise(myers = sum(score) / 2)
}
