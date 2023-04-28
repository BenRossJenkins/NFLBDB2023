# NFLBDB2023
NFL Big Data Bowl 2023

Link to paper: https://www.kaggle.com/code/benjenkins96/causal-impact-of-offensive-linemen-on-pass-plays

# Introduction
We present CLIPP (CausaL Impact of offensive linemen on Pass Plays), a new approach for analyzing the performance of offensive linemen. We apply causal inference methods using NFL player tracking data to quantify the contributions of offensive linemen. Causality is often confused with correlation; simply observing a correlation between two variables or events is not sufficient to imply causality. Causal inference methods are widely used in many applications where randomized control tests are not possible. Here we apply causal inference for the first time to study offensive line performance. Causality allows us to make informed decisions and predictions about the effect of actions of the offensive line.

CLIPP is validated by external rankings and is superior to the correlation-based methods tested. In contrast to previous metrics, such as rush yards over expected, CLIPP is designed to answer causal questions. This is an important distinction, as previous approaches that rely on supervised learning techniques cannot identify cause-and-effect relationships. These methods make faulty assumptions about the data and often attribute a player's contribution to the residual rather than accurately measuring the cause and effect of the player's actions. CLIPP avoids these pitfalls and provides a more robust and accurate assessment of offensive line performance.

CLIPP uses advanced causal inference methods to assign credit to players using player tracking data and contextual information such as yards to go and down. Our extensive testing shows that our results are accurate and reliable. The use of causal inference provides valuable new insights into offensive line performance. We hope this begins the transition from reliance on prediction and correlation towards a focus on cause and effect.

# Methodology

Doubly robust causal inference is a powerful statistical technique that provides an accurate estimate of the causal effect of an action, such as a pass rush in football, on the outcome of a play. This approach combines two statistical models, making it highly effective in accounting for individual differences between players and plays that can greatly affect the outcome of a football play.

Our doubly robust model uses gradient boosting models, which can handle high-dimensional and non-linear data, making them ideal for analyzing complex interactions in football plays. We use these models to estimate the conditional average treatment effect (CATE) and compute CLIPP, which helps us understand how a pass rush affects the outcome of a football play while accounting for differences between players and plays.
                                              𝐶𝐴𝑇𝐸=𝐸[𝑌𝑖|𝑋𝑖=𝑥,𝑇𝑖=1]−𝐸[𝑌𝑖|𝑋𝑖=𝑥,𝑇𝑖=0]

To calculate the CATE, we estimate the expected result of the pass play given individual features (Xi) and given whether the lineman allowed the QB to be pressured, hit, or sacked (Ti=1) or not (Ti=0). The CATE is the difference between these two outcomes in expectation and is always negative because QB pressure, hit, or a sack allowed by offensive linemen decreases the probability of a completed pass.

CLIPP estimates the effect of each offensive lineman on the probability of a pass completion every tenth of a second. If the propensity score model predicts that the lineman has a greater than 50% chance of allowing pressure, a QB hit, or a QB sack, then CLIPP is the conditional average treatment effect. If there is less than a 50% chance, CLIPP is the difference between the expected result of no pressure, hit, or sack allowed (Ti=0) and the expected result of pressure, hit, or sack allowed (Ti=1). We only consider the interval between the snap and the pass. The probabilities are then averaged to provide a play-level summary.

Ensuring the robustness and accuracy of the causal estimate is crucial in causal inference. We use several refutation tests to assess whether the assumptions made to identify the causal effect are reasonable. These tests allow us to verify that our estimator is reliable and trustworthy and are discussed in the Model Evaluation and Refutation Tests section. Overall, doubly robust causal inference is a valuable tool for understanding the impact of specific actions on the outcome of complex systems like football games.

# Play Examples
Failed Block: Below is a play where multiple offensive linemen fail to block their assignment and allow the quarterback to be pressured. Our metric accurately distributed credit to the linemen that effectively blocked their defenders while penalizing the linemen that allowed their defenders to pressure the quarterback. In this case, the Miami offensive line had a positive CLIPP, meaning they collectively increased the probability of a pass completion.

The bottom left figure shows the movements of the offensive line and is colored by CLIPP. The worst performers are shown in red, while the offensive linemen who positively contributed to the play are in green. The middle figure shows the CLIPP of each lineman every tenth of a second. Players above the horizontal line performed positively, while those below decreased the probability of a successful play. The bottom right figure shows the CLIPP of the entire offensive line, and it remained positive throughout the play.



Heavy Pressure and Sack Allowed: In this play, the Atlanta Falcons entire offensive line is being pushed back from heavy pressure by Philadelphia Eagles defense. CLIPP correctly identified the offensive linemen that allowed their QB to be pressured and a subsequent sack. The offensive line collectively reduced the probability of a successful pass by 40 percent (a CLIPP of -0.4).

Great Pass Protection: The following play is an example of excellent pass protection resulting in a completed pass and a 19-yard gain. Jimmy Garoppolo had plenty of time and space to throw to the open receiver Deebo Samuel. The offensive line produced a CLIPP of 0.8, meaning they contributed 80 percent to this successful pass.

# Summary of Results
Best Players: We validated CLIPP results by comparing them with the popular All-Pros and Pro-Bowl ratings. Most of the top ten guards, offensive tackles and centers identified by CLIPP were recognized by these ratings. Figure 4 identifies these players with ratings using dark green.

Our causal estimate outperforms a popular supervised learning model, XGBoost. This supervised model predicts the probability that a lineman will allow a QB to be pressured, hit, or sacked using the same features in the causal model. While XGBoost is a powerful tool that can model the correlations in data, it is limited in its ability to capture causal relationships. Below shows the top ten rankings of offensive linemen from both methods. Note that All-Pros and Pro-Bowlers are rated much higher by our metric compared to the supervised learning model.

Team Performance: The best offensive lines were the Tamba Bay Buccaneers, San Francisco 49ers, Dallas Cowboys, Los Angeles Rams, and Kansas City Chiefs. They contributed an average of 20-22 percent to the success of pass plays. The worst-performing offensive lines were the Carolina Panthers, Miami Dolphins, New York Jets, Jacksonville Jaguars, and Houston Texans.
![__results___15_0-1](https://user-images.githubusercontent.com/48921076/235266831-0937b1bf-1151-426e-b038-c67c9f0daa38.png)

# Model Evaluation and Refutation Tests
We validated CLIPP with independent rankings of offensive lines. Our rankings are strongly correlated with Pro Football Focus (Spearman’s rank correlation of 0.68). The largest discrepancies between the metrics are that CLIPP ranked the Minnesota Vikings and Seattle Seahawks higher while ranking the New York Jets lower. Possible explanations are the PFF measures all plays and evaluated the entire season of offensive line play.
![__results___17_0-1](https://user-images.githubusercontent.com/48921076/235266877-41fe8c18-69a9-4b3b-b790-ede8f62c9e70.png)

The metric CLIPP is positively correlated with both completion percentage and team winning percentage. 
![plot_zoom_png](https://user-images.githubusercontent.com/48921076/235267148-939b4ba0-489d-4bfb-a837-a47526cc281b.png)
![plot_zoom_png-1](https://user-images.githubusercontent.com/48921076/235267195-98c236d4-1759-4e33-996f-003cd412870f.png)

We ensured that our causal model is well-balanced. The weighting reduced the covariate imbalance between the offensive linemen who allowed their QB to be hurried, hit, or sacked (Ti=1) and those who didn’t (Ti=0). Variables after weighting are shown in blue, and before weighting are shown in orange. The variables after weighting are lower and below the 0.1 threshold (vertical dashed line in Figure 7). This is expected for a well-balanced model. Lastly, these two graphs are similar indicating the model didn’t overfit the data.
![__results___19_0-2](https://user-images.githubusercontent.com/48921076/235267036-e5c5ff3a-61ec-41f3-b91e-a4b7c7a36369.png)

We evaluate the goodness of fit by assessing how well-calibrated the model is (Figure 8). An ideal model would have predicted probabilities equal to the observed probability (shown by the dashed diagonal line). The model is well-calibrated. In a few isolated cases, the validation data incorrectly predicts a lineman allowed the QB to be pressured, hit, or sacked. We also evaluate the model using ROC curves shown in the Appendix.
![__results___21_0-1](https://user-images.githubusercontent.com/48921076/235267238-8e449ade-00f0-44e6-bf2a-f4ef10fb16fd.png)

CLIPP was validated using a receiver operating characteristic curve (Figure 9). We used it to evaluate potential violations of the positivity assumption and how well-balanced the two groups are after weighting. A large area under the curve (AUC) would suggest that there are large differences in the linemen who allow a QB hit, pressure, or sack (Ti=1) and those who don't (Ti=0). The weighted ROC curve (orange curve) is close to the ideal diagonal line meaning that the two groups are well-balanced and similar to what you would expect in a randomized controlled experiment. Additionally, the propensity and expected curves are similar indicating a well-specified model.
![__results___23_0-1](https://user-images.githubusercontent.com/48921076/235267356-bdb68823-c8a9-41bf-8c4d-d456f0ede14e.png)

To confirm the reliability of our causal estimate, we conducted several robustness tests. One such test involved substituting the treatment with a placebo variable, which resulted in the causal effect becoming statistically insignificant. This suggests that the original treatment was indeed responsible for the observed effect. Additionally, we ran the model on a randomly selected subset of the data and found that the causal effect remained stable, further supporting the validity of our estimate. These findings suggest that we have accurately identified the underlying causal relationship in our analysis.

# Conclusion
We present a causal framework and a new metric CLIPP that helps to better understand the contributions of offensive linemen to the outcome of a pass play. By focusing on causality, we generate more accurate results than relying solely on methods based on correlation. CLIPP has been thoroughly evaluated and provides a way for the NFL and teams to measure the direct impact of offensive linemen on the outcome of a pass play.

Our results show that causal inference methods are the best way to identify and estimate individual contributions to a given outcome. Previous NFL metrics have certainly provided valuable insights from player tracking data, but they are limited by their reliance on methods that cannot measure cause and effect. These metrics use supervised learning models and attribute player performance to the difference between actual and predicted values.

There is potential to expand our causal framework and metric. Working with domain experts would allow us to identify confounding variables. We could also consider success in pass plays based on yards gained or whether the pass resulted in a first down. Finally, we could extend our analysis to measure the impact of other positions, such as the defensive line, which would give us a more comprehensive understanding of how individual players and positions affect the outcome of a play.

# References
Pearl, Judea, and Dana Mackenzie. The Book of Why: The New Science of Cause and Effect. Penguin Books, 2018.

The Next Gen Stats Analytics Team. “Next Gen Stats: Intro to Expected Rushing Yards.” NFL.com, 20 July 2020, https://www.nfl.com/news/next-gen-stats-intro-to-expected-rushing-yards.

Funk, Michele Jonsson, et al. “Doubly Robust Estimation of Causal Effects.” American Journal of Epidemiology, U.S. National Library of Medicine, 1 Apr. 2011, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3070495/.

Monson, Sam. “Final 2021 NFL Offensive Line Rankings.” PFF, PFF, 12 Jan. 2022, https://www.pff.com/news/nfl-final-2021-offensive-line-rankings.
