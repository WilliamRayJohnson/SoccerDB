SELECT R.Name, AVG(card.Cards)
    FROM (SELECT R.Name, Count(C.Color) AS cards
        FROM referee R
        JOIN card_penalty C ON R.Ref_id = C.Ref_id
        GROUP BY R.Ref_id
        HAVING C.Color = "red") as card